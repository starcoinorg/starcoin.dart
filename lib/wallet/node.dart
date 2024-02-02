import 'dart:typed_data';

import 'package:starcoin_wallet/serde/serde.dart';
import 'package:starcoin_wallet/starcoin/starcoin.dart';
import 'package:starcoin_wallet/wallet/account.dart';
import 'package:starcoin_wallet/wallet/client.dart';
import 'package:http/http.dart';
import 'package:starcoin_wallet/wallet/hash.dart';
import 'package:starcoin_wallet/wallet/helper.dart';
import 'package:starcoin_wallet/wallet/wallet_client.dart';

import 'host_manager.dart';

class Node {

  Node(this.hostMananger);

  HostMananger hostMananger;

  Future<dynamic> defaultAccount() async {
    final client = StarcoinClient(hostMananger);

    var result = await client.makeRPCCall('account.default', []);
    return result;
  }

  Future<dynamic> nodeInfo() async {
    final client = StarcoinClient(this.hostMananger);

    var result = await client.makeRPCCall('node.info', []);
    return result;
  }

  Future<dynamic> syncStatus() async {
    final client = StarcoinClient(this.hostMananger);

    var result = await client.makeRPCCall('sync.status', []);
    return result;
  }

  Future<dynamic> syncProgress() async {
    final client = StarcoinClient(this.hostMananger);

    var result = await client.makeRPCCall('sync.progress', []);
    return result;
  }

  Future<dynamic> exportAccount(String accountAddress, String password) async {
    final client = StarcoinClient(this.hostMananger);

    var result =
        await client.makeRPCCall('account.export', [accountAddress, password]);
    return result;
  }

  Future<dynamic> importAccount(String accountAddress, String privateKey, String password) async {
    final client = StarcoinClient(this.hostMananger);

    var result =
        await client.makeRPCCall('account.import', [accountAddress, privateKey, password]);
    return result;
  }

  Future<dynamic> removeAccount(String accountAddress, String password) async {
    final client = StarcoinClient(this.hostMananger);

    var result =
        await client.makeRPCCall('account.remove', [accountAddress, password]);
    return result;
  }

  Future<dynamic> setDefaultAccount(String accountAddress) async {
    final client = StarcoinClient(this.hostMananger);

    var result =
        await client.makeRPCCall('account.set_default_account', [accountAddress]);
    return result;
  }


  Future<dynamic> accountList() async {
    final client = StarcoinClient(this.hostMananger);

    var result =
        await client.makeRPCCall('account.list', []);
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

    final hash = lcsHash(structTag.bcsSerialize(), "STARCOIN::StructTag");
    path.addAll(hash);

    final client = WalletClient(this.hostMananger);
    final result =
        await client.getStateJson(sender, DataPathResourceItem(structTag));

    if (result == null) {
      return Int128(0, 0);
    }
    final balanceResource =
        BalanceResource.bcsDeserialize(Uint8List.fromList(result));
    return balanceResource.token;
  }
}
