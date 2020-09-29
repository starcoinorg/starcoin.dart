import 'package:starcoin_wallet/wallet/account.dart';
import 'package:starcoin_wallet/wallet/keyfactory.dart';
import 'package:starcoin_wallet/wallet/client.dart';
import 'package:http/http.dart';

class TransactionWithInfo {
  Map<String, dynamic> txn;
  Map<String, dynamic> txnInfo;

  TransactionWithInfo(this.txn, this.txnInfo);
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

  Future<dynamic> getTransactionDetail(String hash) async {
    final txn = await getTransaction(hash);
    final info = await getTransactionInfo(hash);
    return TransactionWithInfo(txn, info);
  }

  void addAccount(Account account) {
    String address = account.keyPair.getAddress();
    _accounts[address] = account;
  }
}
