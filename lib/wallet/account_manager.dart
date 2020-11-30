import 'package:starcoin_wallet/wallet/account.dart';
import 'package:starcoin_wallet/wallet/keyfactory.dart';

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
    Account account = new Account(_keyFactory.generateKey(depth));
    addAccount(account);
    return account;
  }

  void addAccount(Account account) {
    String address = account.keyPair.getAddress();
    _accounts[address] = account;
  }
}
