import 'dart:typed_data';

import 'package:starcoin_wallet/serde/serde.dart';
import 'package:starcoin_wallet/starcoin/starcoin.dart';
import 'package:starcoin_wallet/wallet/account.dart';
import 'package:starcoin_wallet/wallet/client.dart';
import 'package:http/http.dart';
import 'package:starcoin_wallet/wallet/hash.dart';
import 'package:starcoin_wallet/wallet/helper.dart';
import 'package:starcoin_wallet/wallet/wallet_client.dart';

class Node {
  final String _url;

  Node(this._url);

  Future<dynamic> defaultAccount() async {
    final client = StarcoinClient(_url, Client());

    var result = await client.makeRPCCall('account.default', []);
    return result;
  }

  Future<dynamic> nodeInfo() async {
    final client = StarcoinClient(_url, Client());

    var result = await client.makeRPCCall('node.info', []);
    return result;
  }

  Future<dynamic> syncStatus() async {
    final client = StarcoinClient(_url, Client());

    var result = await client.makeRPCCall('sync.status', []);
    return result;
  }

  Future<dynamic> syncProgress() async {
    final client = StarcoinClient(_url, Client());

    var result = await client.makeRPCCall('sync.progress', []);
    return result;
  }

  Future<Int128> balanceOfStc(AccountAddress sender) async {
    return await balanceOf(
        sender,
        StructTag(
            AccountAddress(
                Helpers.hexToBytes("00000000000000000000000000000001")),
            Identifier("STC"),
            Identifier("STC"),
            List()));
  }

  Future<Int128> balanceOf(AccountAddress sender, StructTag tokenType) async {
    final structTag = StructTag(
        AccountAddress(Helpers.hexToBytes("00000000000000000000000000000001")),
        Identifier("Account"),
        Identifier("Balance"),
        List.from([TypeTagStructItem(tokenType)]));
    final path = List<int>();
    path.add(RESOURCE_TAG);

    final hash = lcsHash(structTag.lcsSerialize(), "LIBRA::StructTag");
    path.addAll(hash);

    final client = WalletClient(_url);
    final result = await client.getState(sender, Uint8List.fromList(path));

    if (result == null) {
      return Int128(0, 0);
    }
    final balanceResource =
        BalanceResource.lcsDeserialize(Uint8List.fromList(result));
    return balanceResource.token;
  }
}
