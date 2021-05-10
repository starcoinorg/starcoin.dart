import 'package:starcoin_wallet/starcoin/starcoin.dart';
import 'package:starcoin_wallet/wallet/account.dart';
import 'package:starcoin_wallet/wallet/client.dart';
import 'package:http/http.dart';
import 'package:optional/optional.dart';
import 'package:starcoin_wallet/wallet/helper.dart';
import 'package:web_socket_channel/io.dart';

import 'host_manager.dart';

enum EventType {
  Deposit,
  WithDraw,
}

class TransactionWithInfo {
  final Map<String, dynamic> txn;
  final Map<String, dynamic> txnInfo;
  EventType paymentType;
  Map<String, dynamic> event;

  TransactionWithInfo(this.txn, this.txnInfo);
}

class WalletClient {

  WalletClient(this.hostMananger);

  HostMananger hostMananger;

  void setHostManager(HostMananger hostMananger){
    this.hostMananger;
  }

  Future<dynamic> getNodeInfo() async {
    final client = StarcoinClient(this.hostMananger);
    final result = await client.makeRPCCall('node.info');
    return result;
  }

  Future<dynamic> getTransaction(String hash) async {
    final client = StarcoinClient(this.hostMananger);
    final result = await client.makeRPCCall('chain.get_transaction', [hash]);
    return result;
  }

  Future<dynamic> getTransactionInfo(String hash) async {
    final client = StarcoinClient(this.hostMananger);
    final result =
        await client.makeRPCCall('chain.get_transaction_info', [hash]);
    return result;
  }

  Future<dynamic> getBlockByHash(String hash) async {
    final client = StarcoinClient(this.hostMananger);
    final result = await client.makeRPCCall('chain.get_block_by_hash', [hash]);
    return result;
  }

  Future<TransactionWithInfo> getTransactionDetail(String hash) async {
    final txn = await getTransaction(hash);
    final info = await getTransactionInfo(hash);
    return TransactionWithInfo(txn, info);
  }

  Future<dynamic> getEvents(EventFilter eventFilter) async {
    final client = StarcoinClient(this.hostMananger);
    final result = await client.makeRPCCall('chain.get_events', [eventFilter]);
    return result;
  }

  Future<dynamic> getTxnEvents(Account account, Optional<int> fromBlockNumber,
      Optional<int> toBlockNumber, Optional<int> limit) async {
    final recvEventKey = account.recvEventKey();
    final sendEventKey = account.sendEventKey();
    final eventFilter = EventFilter(
        fromBlockNumber, toBlockNumber, [sendEventKey, recvEventKey], limit);
    return await getEvents(eventFilter);
  }

  Future<List<TransactionWithInfo>> getTxnList(
      Account account,
      Optional<int> fromBlockNumber,
      Optional<int> toBlockNumber,
      Optional<int> limit) async {
    final events =
        await getTxnEvents(account, fromBlockNumber, toBlockNumber, limit)
            as List;

    List<TransactionWithInfo> txnList = new List(events.length);
    for (int i = 0; i < events.length; i++) {
      final txnHash = events[i]['transaction_hash'];
      var txnWithInfo = await getTransactionDetail(txnHash);
      txnWithInfo.event = events[i];
      if (events[i]['type_tag']['Struct']['name'] == 'DepositEvent') {
        txnWithInfo.paymentType = EventType.Deposit;
      } else {
        txnWithInfo.paymentType = EventType.WithDraw;
      }
      txnList[i] = txnWithInfo;
    }
    return txnList;
  }

  Future<List<int>> getState(AccountAddress sender, DataPath path) async {
    final jsonRpc = StarcoinClient(this.hostMananger);

    final accessPath = AccessPath(sender, path);

    final result = await jsonRpc.makeRPCCall(
        'state_hex.get', [Helpers.byteToHex(accessPath.bcsSerialize())]);

    if (result == null) {
      return null;
    }

    final listInt = List<int>();
    for (var i in result) {
      listInt.add(i);
    }

    return listInt;
  }

  Future<List<int>> getStateJson(AccountAddress sender, DataPath path) async {
    final jsonRpc = StarcoinClient(this.hostMananger);
    //"$address/1/$address::Account::Balance<0x00000000000000000000000000000001::STC::STC>";

    final result = await jsonRpc
        .makeRPCCall('state.get', [formatAccessPath(sender, path)]);

    if (result == null) {
      return null;
    }

    final listInt = List<int>();
    for (var i in result) {
      listInt.add(i);
    }

    return listInt;
  }

  String formatAccessPath(AccountAddress sender, DataPath path) {
    var accessPath = sender.toString();
    if (path is DataPathCodeItem) {
      accessPath += "/0";
      accessPath += "/" + path.value.value;
    }
    if (path is DataPathResourceItem) {
      accessPath += "/1";
      accessPath += "/" + path.value.address.toString();
      accessPath += "::" + path.value.module.value;
      accessPath += "::" + path.value.name.value;
      if (path.value.type_params != null && path.value.type_params.isNotEmpty) {
        for (TypeTag tag in path.value.type_params) {
          if (tag is TypeTagStructItem) {
            accessPath += "<" + tag.value.address.toString();
            accessPath += "::" + tag.value.module.value;
            accessPath += "::" + tag.value.name.value + ">";
          }
        }
      }
    }
    return accessPath;
  }
}

class BatchClient {
  final String wsURL;
  ClientController clientController;

  BatchClient(this.wsURL) {
    clientController = ClientController(
        IOWebSocketChannel.connect(Uri.parse(this.wsURL)).cast<String>());
  }

  Future<dynamic> getTransactions(List<String> hashList) async {
    final result =
        await clientController.batchCall('chain.get_transaction', hashList);
    return result;
  }

  Future<dynamic> getTransactionsInfo(List<String> hashList) async {
    final result = await clientController.batchCall(
        'chain.get_transaction_info', hashList);
    return result;
  }

  Future<List<TransactionWithInfo>> getTxnListBatch(
      WalletClient client,
      Account account,
      Optional<int> fromBlockNumber,
      Optional<int> toBlockNumber,
      Optional<int> limit) async {
    final events = await client.getTxnEvents(
        account, fromBlockNumber, toBlockNumber, limit) as List;

    List<String> hashList = new List(events.length);
    for (int i = 0; i < events.length; i++) {
      hashList[i] = events[i]['transaction_hash'];
    }
    final txns = await getTransactions(hashList);
    final txnsInfo = await getTransactionsInfo(hashList);
    List<TransactionWithInfo> txnList = new List(events.length);
    for (int i = 0; i < events.length; i++) {
      final txnHash = events[i]['transaction_hash'];
      var txnWithInfo = TransactionWithInfo(txns[txnHash], txnsInfo[txnHash]);
      txnWithInfo.event = events[i];
      if (events[i]['type_tag']['Struct']['name'] == 'DepositEvent') {
        txnWithInfo.paymentType = EventType.Deposit;
      } else {
        txnWithInfo.paymentType = EventType.WithDraw;
      }
      txnList[i] = txnWithInfo;
    }
    return txnList;
  }
}
