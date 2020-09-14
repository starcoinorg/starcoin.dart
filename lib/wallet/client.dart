import 'package:starcoin_wallet/wallet/json_rpc.dart';

import 'package:http/http.dart';

class StarcoinClient {
  final JsonRPC _jsonRpc;

  bool printErrors = false;

  StarcoinClient(String url, Client httpClient)
      : _jsonRpc = JsonRPC(url, httpClient);

  Future<T> makeRPCCall<T>(String function, [List<dynamic> params]) async {
    try {
      final data = await _jsonRpc.call(function, params);
      // ignore: only_throw_errors
      if (data is Error || data is Exception) throw data;

      return data.result as T;
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      if (printErrors) print(e);

      rethrow;
    }
  }
}
