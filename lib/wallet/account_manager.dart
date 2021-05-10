import 'package:starcoin_wallet/wallet/account.dart';
import 'package:starcoin_wallet/wallet/keyfactory.dart';

import 'host_manager.dart';

class Wallet {
  KeyFactory _keyFactory;
  int _lastChild = 0;
  Map _accounts = new Map();
  HostMananger hostMananger;

  Wallet({String mnemonic, String salt = 'starcoin',  HostMananger hostMananger}) {
    _keyFactory = new KeyFactory(salt, mnemonic: mnemonic);
    this.hostMananger = hostMananger;
  }

  Account newAccount() {
    Account newAccount = generateAccount(_lastChild);
    _lastChild++;
    return newAccount;
  }

  Account generateAccount(int depth) {
    assert(depth >= 0);
    Account account = new Account(_keyFactory.generateKey(depth),this.hostMananger);
    addAccount(account);
    return account;
  }

  void addAccount(Account account) {
    String address = account.keyPair.getAddress();
    _accounts[address] = account;
  }

  void setHostManager(HostMananger hostMananger){
    this.hostMananger= hostMananger;
  }
}
