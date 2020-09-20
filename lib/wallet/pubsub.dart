import 'package:starcoin_wallet/starcoin/starcoin.dart';
import 'package:starcoin_wallet/wallet/json_rpc.dart';
import 'package:json_rpc_2/json_rpc_2.dart' as rpc;
import 'dart:async';
import 'package:stream_channel/stream_channel.dart';
import 'package:starcoin_wallet/wallet/helper.dart';
import 'dart:developer';

const _pingDuration = Duration(seconds: 2);

class FilterCreationParams {
  final String method;
  final List<dynamic> params;

  FilterCreationParams(this.method, this.params);
}

class PubSubCreationParams {
  final List<dynamic> params;

  PubSubCreationParams(this.params);
}

abstract class Filter<T> {
  FilterCreationParams create();
  PubSubCreationParams createPubSub();
  T parseChanges(dynamic log);
}

class NewBlockFilter extends Filter<dynamic> {
  @override
  FilterCreationParams create() {
    return null;
  }

  @override
  dynamic parseChanges(dynamic log) {
    return log;
  }

  @override
  PubSubCreationParams createPubSub() {
    return PubSubCreationParams(
        [Helpers.byteToHex(KindNewHeadsItem().lcsSerialize())]);
  }
}

class PubSubClient {
  final List<InstantiatedFilter> _filters = [];
  final StreamChannel<String> connector;

  final JsonRPC _rpc;

  Timer _ticker;
  bool _isRefreshing = false;
  bool _clearingBecauseSocketClosed = false;

  final List<Future> _pendingUnsubcriptions = [];

  rpc.Peer _streamRpcPeer;

  PubSubClient(this.connector, this._rpc);

  Stream<T> addFilter<T>(Filter<T> filter) {
    final pubSubParams = filter.createPubSub();
    final supportsPubSub = pubSubParams != null;

    InstantiatedFilter instantiated;
    instantiated = InstantiatedFilter(filter, supportsPubSub, () {
      _pendingUnsubcriptions.add(uninstall(instantiated));
    });
    _filters.add(instantiated);

    if (instantiated.isPubSub) {
      _registerToPubSub(instantiated, pubSubParams);
    } else {
      _registerToAPI(instantiated);
      //_startTicking();
    }

    return instantiated.controller.stream;
  }

  Future<void> _registerToAPI(InstantiatedFilter filter) async {
    final request = filter.filter.create();

    try {
      final response = await _rpc.call(request.method, request.params);
      filter.id = response.result as String;
    } on RPCError catch (e, s) {
      filter.controller.addError(e, s);
      await filter.controller.close();
      _filters.remove(filter);
    }
  }

  Future<void> _registerToPubSub(
      InstantiatedFilter filter, PubSubCreationParams params) async {
    final peer = _connectWithPeer();

    try {
      final response =
          await peer.sendRequest('starcoin_subscribe_hex', params.params);
      filter.id = response.toString();
    } on rpc.RpcException catch (e, s) {
      filter.controller.addError(e, s);
      await filter.controller.close();
      _filters.remove(filter);
    }
  }

  void _startTicking() {
    _ticker ??= Timer.periodic(_pingDuration, (_) => _refreshFilters());
  }

  Future<void> _refreshFilters() async {
    if (_isRefreshing) return;
    _isRefreshing = true;

    try {
      final filterSnapshot = List.of(_filters);

      for (final filter in filterSnapshot) {
        final updatedData =
            await _rpc.call('eth_getFilterChanges', [filter.id]);

        for (final payload in updatedData.result) {
          if (!filter.controller.isClosed) {
            _parseAndAdd(filter, payload);
          }
        }
      }
    } finally {
      _isRefreshing = false;
    }
  }

  void handlePubSubNotification(rpc.Parameters params) {
    final paramsMap = params.asMap;
    final id = paramsMap['subscription'].toString();
    final result = paramsMap['result'];

    final filter = _filters.singleWhere((f) => f.isPubSub && f.id == id,
        orElse: () => null);
    _parseAndAdd(filter, result);
  }

  void handleConnectionClosed() {
    try {
      _clearingBecauseSocketClosed = true;
      final pubSubFilters = _filters.where((f) => f.isPubSub).toList();

      pubSubFilters.forEach(uninstall);
    } finally {
      _clearingBecauseSocketClosed = false;
    }
  }

  void _parseAndAdd(InstantiatedFilter filter, dynamic payload) {
    //final parsed = filter.filter.parseChanges(payload);

    try {
      filter.controller.add(payload);
    } catch (e, s) {
      log("e is $e, s is $s");
    }
  }

  Future uninstall(InstantiatedFilter filter) async {
    await filter.controller.close();
    _filters.remove(filter);

    if (filter.isPubSub && !_clearingBecauseSocketClosed) {
      final connection = _connectWithPeer();
      await connection.sendRequest('starcoin_unsubscribe_hex', [filter.id]);
    } else {
      await _rpc.call('eth_uninstallFilter', [filter.id]);
    }
  }

  Future dispose() async {
    _ticker?.cancel();
    final remainingFilters = List.of(_filters);

    await Future.forEach(remainingFilters, uninstall);
    await Future.wait(_pendingUnsubcriptions);

    _pendingUnsubcriptions.clear();
  }

  rpc.Peer _connectWithPeer() {
    if (_streamRpcPeer != null && !_streamRpcPeer.isClosed) {
      return _streamRpcPeer;
    }

    _streamRpcPeer = rpc.Peer(connector);

    _streamRpcPeer.registerMethod('starcoin_subscription_hex',
        (rpc.Parameters params) {
      handlePubSubNotification(params);
    });

    _streamRpcPeer.listen().then((_) {
      // .listen() will complete when the socket is closed, so reset client
      _streamRpcPeer = null;
      handleConnectionClosed();
    });

    return _streamRpcPeer;
  }
}

class InstantiatedFilter {
  /// The id of this filter. This value will be obtained from the API after the
  /// filter has been set up and is `null` before that.
  String id;
  final Filter<dynamic> filter;

  /// Whether the filter is listening on a websocket connection.
  final bool isPubSub;

  final StreamController<dynamic> controller;

  InstantiatedFilter(this.filter, this.isPubSub, Function() onCancel)
      : this.controller = StreamController(onCancel: onCancel);
}
