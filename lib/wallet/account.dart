import 'dart:typed_data';
import 'package:starcoin_wallet/wallet/keypair.dart';
import 'package:starcoin_wallet/wallet/event.dart';

class AccountState {
  Uint8List authenticationKey;
  BigInt balance, sequenceNumber;
  EventHandle receivedEvents, sentEvents;
  bool delegatedWithdrawalCapability;
  bool delegatedKeyRotationCapability;

  AccountState(this.authenticationKey,
      {BigInt balance,
      EventHandle receivedEvents,
      EventHandle sentEvents,
      BigInt sequenceNumber,
      this.delegatedWithdrawalCapability = false,
      this.delegatedKeyRotationCapability = false}) {
    this.balance = balance == null ? BigInt.zero : balance;
    EventHandle defaultEventHandle =
        new EventHandle(Uint8List.fromList([]), BigInt.zero);
    this.receivedEvents =
        receivedEvents == null ? defaultEventHandle : receivedEvents;
    this.sentEvents = sentEvents == null ? defaultEventHandle : sentEvents;
    this.sequenceNumber = sequenceNumber == null ? BigInt.zero : sequenceNumber;
  }
}

class Account {
  KeyPair keyPair;
  String _address;

  Account(this.keyPair);

  static Account fromPrivateKey(Uint8List privateKey) {
    return new Account(new KeyPair(privateKey));
  }

  String getAddress() {
    if (_address != null && _address.isNotEmpty) {
      return _address;
    }
    _address = keyPair.getAddress();
    return _address;
  }
}
