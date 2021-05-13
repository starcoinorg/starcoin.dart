import 'package:http/http.dart';
import 'package:starcoin_wallet/starcoin/starcoin.dart';
import 'package:starcoin_wallet/wallet/account.dart';
import 'package:starcoin_wallet/wallet/host_manager.dart';
import 'package:starcoin_wallet/wallet/json_rpc.dart';
import 'package:json_rpc_2/json_rpc_2.dart' as rpc;
import 'dart:async';
import 'package:stream_channel/stream_channel.dart';
import 'dart:developer';
import 'package:optional/optional.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:pedantic/pedantic.dart';

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
    return PubSubCreationParams([KindNewHeadsItem()]);
  }
}

class NewMintBlockFilter extends Filter<dynamic> {
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
    return PubSubCreationParams([KindNewMintBlockItem()]);
  }
}

class NewTxnSendRecvEventFilter extends Filter<dynamic> {
  final Account account;

  NewTxnSendRecvEventFilter(this.account);

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
    final recvEventKey = account.recvEventKey();
    final sendEventKey = account.sendEventKey();
    final eventFilter = EventFilter(Optional.of(0), Optional.empty(),
        [sendEventKey, recvEventKey], Optional.empty());
    //print(jsonEncode([KindEventsItem(), eventFilter]));
    return PubSubCreationParams([KindEventsItem(), eventFilter]);
  }
}

class PubSubClient {
  final List<InstantiatedFilter> _filters = [];
  StreamChannel<String> connector;

  JsonRPC _rpc;

  Timer _ticker;
  bool _isRefreshing = false;
  bool _clearingBecauseSocketClosed = false;

  final List<Future> _pendingUnsubcriptions = [];

  rpc.Peer _streamRpcPeer;

  PubSubClient(this.hostMananger);

  HostMananger hostMananger;

  Future<Stream<T>> addFilter<T>(Filter<T> filter) async{
    while(true){
      try{
        return await tryConnect(filter);
      }  on StateError catch(_e){ 
        hostMananger.removeFailureHost();
        log("remove host ${hostMananger.getHttpBaseUrl()} from host manager"); 
        continue;
      } on WebSocketChannelException catch (e) {
        hostMananger.removeFailureHost();
        log("remove host ${hostMananger.getHttpBaseUrl()} from host manager"); 
        continue;
      } catch(e){
        rethrow;
      }
    }
  }

  Future<Stream<T>> tryConnect<T>(Filter<T> filter) async{
    connector = IOWebSocketChannel.connect(Uri.parse(hostMananger.getWsBaseUrl())).cast();
    _rpc = JsonRPC(hostMananger.getHttpBaseUrl(), Client());

    final pubSubParams = filter.createPubSub();
    final supportsPubSub = pubSubParams != null;

    InstantiatedFilter instantiated;
    instantiated = InstantiatedFilter(filter, supportsPubSub, () {
      _pendingUnsubcriptions.add(uninstall(instantiated));
    });
    _filters.add(instantiated);

    if (instantiated.isPubSub) {
      await _registerToPubSub(instantiated, pubSubParams);
    } else {
      await _registerToAPI(instantiated);
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
    final peer = await _connectWithPeer();

    try {
      final response =
          await peer.sendRequest('starcoin_subscribe', params.params);      
      filter.id = response.toString();
    } catch (e, s) {
      filter.controller.addError(e, s);
      await filter.controller.close();
      _filters.remove(filter);
      rethrow;
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
      final connection = await _connectWithPeer();
      await connection.sendRequest('starcoin_unsubscribe', [filter.id]);
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
    connector.sink.close();
  }

  Future<rpc.Peer> _connectWithPeer() async{
    if (_streamRpcPeer != null && !_streamRpcPeer.isClosed) {
      return _streamRpcPeer;
    }

    _streamRpcPeer = rpc.Peer(connector);

    _streamRpcPeer.registerMethod('starcoin_subscription',
        (rpc.Parameters params) {
      handlePubSubNotification(params);
    });

    _streamRpcPeer.listen().then((_) {
      // .listen() will complete when the socket is closed, so reset client
      _streamRpcPeer = null;
      handleConnectionClosed();
    }).catchError((e) {
      //print(e);     // Finally, callback fires.
      return;
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
