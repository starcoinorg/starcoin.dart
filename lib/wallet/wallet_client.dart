import 'package:starcoin_wallet/starcoin/starcoin.dart';
import 'package:starcoin_wallet/wallet/account.dart';
import 'package:starcoin_wallet/wallet/client.dart';
import 'package:http/http.dart';
import 'package:optional/optional.dart';

enum PaymentType {
  Send,
  Recieve,
}

class TransactionWithInfo {
  final Map<String, dynamic> txn;
  final Map<String, dynamic> txnInfo;
  PaymentType paymentType;
  Map<String, dynamic> event;

  TransactionWithInfo(this.txn, this.txnInfo);
}

class WalletClient {
  final String url;

  WalletClient(this.url);

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
      if (events[i]['type_tags']['Struct']['name'] == 'ReceivedPaymentEvent') {
        txnWithInfo.paymentType = PaymentType.Recieve;
      } else {
        txnWithInfo.paymentType = PaymentType.Send;
      }
      txnList[i] = txnWithInfo;
    }
    return txnList;
  }
}
