import 'dart:convert';

import 'package:starcoin_wallet/starcoin/starcoin.dart';
import 'package:starcoin_wallet/wallet/account.dart';
import 'package:starcoin_wallet/wallet/keyfactory.dart';
import 'package:starcoin_wallet/wallet/client.dart';
import 'package:http/http.dart';
import 'package:optional/optional.dart';

class TransactionWithInfo {
  final Map<String, dynamic> txn;
  final Map<String, dynamic> txnInfo;

  TransactionWithInfo(this.txn, this.txnInfo);

  @override
  String toString() {
    "txn is " + jsonEncode(txn) + " txn_info is " + jsonEncode(txnInfo);
  }
}

class Wallet {
  KeyFactory _keyFactory;
  int _lastChild = 0;
  Map _accounts = new Map();
  String url;

  Wallet({String mnemonic, String url, String salt = 'starcoin'}) {
    _keyFactory = new KeyFactory(salt, mnemonic: mnemonic);
    this.url = url;
  }

  Account newAccount() {
    Account newAccount = generateAccount(_lastChild);
    _lastChild++;
    return newAccount;
  }

  Account generateAccount(int depth) {
    assert(depth >= 0);
    Account account = new Account(_keyFactory.generateKey(depth), url);
    addAccount(account);
    return account;
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
      txnList[i] = txnWithInfo;
    }
    return txnList;
  }

  void addAccount(Account account) {
    String address = account.keyPair.getAddress();
    _accounts[address] = account;
  }
}
