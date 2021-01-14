import 'dart:typed_data';

import 'package:starcoin_wallet/serde/serde.dart';
import 'package:starcoin_wallet/starcoin/starcoin.dart';
import 'package:starcoin_wallet/wallet/account.dart';
import 'package:starcoin_wallet/wallet/client.dart';
import 'package:http/http.dart';
import 'package:optional/optional.dart';
import 'package:starcoin_wallet/wallet/helper.dart';
import 'package:web_socket_channel/io.dart';

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
  final String url;

  WalletClient(this.url);

  Future<dynamic> getNodeInfo() async {
    final client = StarcoinClient(url, Client());
    final result = await client.makeRPCCall('node.info');
    return result;
  }

  Future<dynamic> getTransaction(String hash) async {
    final client = StarcoinClient(url, Client());
    final result = await client.makeRPCCall('chain.get_transaction', [hash]);
    return result;
  }

  Future<dynamic> getTransactionInfo(String hash) async {
    final client = StarcoinClient(url, Client());
    final result =
        await client.makeRPCCall('chain.get_transaction_info', [hash]);
    return result;
  }

  Future<dynamic> getBlockByHash(String hash) async {
    final client = StarcoinClient(url, Client());
    final result = await client.makeRPCCall('chain.get_block_by_hash', [hash]);
    return result;
  }

  Future<TransactionWithInfo> getTransactionDetail(String hash) async {
    final txn = await getTransaction(hash);
    final info = await getTransactionInfo(hash);
    return TransactionWithInfo(txn, info);
  }

  Future<dynamic> getEvents(EventFilter eventFilter) async {
    final client = StarcoinClient(url, Client());
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
    final jsonRpc = StarcoinClient(url, Client());

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
