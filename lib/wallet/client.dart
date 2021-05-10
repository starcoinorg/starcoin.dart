import 'package:starcoin_wallet/wallet/host_manager.dart';
import 'package:starcoin_wallet/wallet/json_rpc.dart';

import 'package:http/http.dart';

import 'dart:async';

import 'package:stream_channel/stream_channel.dart';

import 'package:json_rpc_2/json_rpc_2.dart' as json_rpc;

class StarcoinClient {
  //final JsonRPC _jsonRpc;

  bool printErrors = false;

  HostMananger hostMananger;

  StarcoinClient(this.hostMananger);
  
  //StarcoinClient(String url, Client httpClient)
  //    : _jsonRpc = JsonRPC(url, httpClient);      

  Future<T> makeRPCCall<T>(String function, [List<dynamic> params]) async {
    try {
      final _jsonRpc = JsonRPC(hostMananger.getHttpBaseUrl(), Client());
      final data = await _jsonRpc.call(function, params);
      // ignore: only_throw_errors
      if (data is Error || data is Exception) throw data;
      return data.result as T;
      ////
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      if (printErrors) print(e);

      rethrow;
    }
  }
}

class ClientController {
  /// The client.
  json_rpc.Client get client => _client;
  json_rpc.Client _client;

  ClientController(StreamChannel<String> connector) {
    _client = json_rpc.Client(connector);
    _client.listen();
  }

  Future<Map<dynamic, dynamic>> batchCall(
      String function, List<dynamic> params) async {
    Map<dynamic, dynamic> result = new Map();
    var futures = <Future>[];
    _client.withBatch(() => {
          for (int i = 0; i < params.length; i++)
            {
              futures.add(_client.sendRequest(function, [params[i]]).then(
                  (value) => result.putIfAbsent(params[i], () => value)))
            }
        });
    await Future.wait(futures);
    return result;
  }
}
