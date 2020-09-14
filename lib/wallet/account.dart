import 'dart:developer';
import 'dart:typed_data';
import 'package:starcoin_wallet/serde/serde.dart';
import 'package:starcoin_wallet/starcoin/starcoin.dart';
import 'package:starcoin_wallet/wallet/keypair.dart';
import 'package:starcoin_wallet/wallet/helper.dart';
import 'package:starcoin_wallet/wallet/hash.dart';
import 'package:starcoin_wallet/transaction_builder.dart';
import 'package:starcoin_wallet/wallet/client.dart';

import 'package:http/http.dart';

const RESOURCE_TAG = 1;

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
        new EventHandle(0, EventKey(Bytes(List())));
    this.receivedEvents =
        receivedEvents == null ? defaultEventHandle : receivedEvents;
    this.sentEvents = sentEvents == null ? defaultEventHandle : sentEvents;
    this.sequenceNumber = sequenceNumber == null ? BigInt.zero : sequenceNumber;
  }
}

class Account {
  KeyPair keyPair;
  String _address;
  String url;

  Account(KeyPair keyPair, String Url) {
    this.keyPair = keyPair;
    this.url = Url;
  }

  static Account fromPrivateKey(Uint8List privateKey, String url) {
    return new Account(new KeyPair(privateKey), url);
  }

  String getAddress() {
    if (_address != null && _address.isNotEmpty) {
      return _address;
    }
    _address = keyPair.getAddress();
    return _address;
  }

  Future<Int128> balanceOfStc() async {
    return await balanceOf(StructTag(
        AccountAddress(Helpers.hexToBytes("00000000000000000000000000000001")),
        Identifier("STC"),
        Identifier("STC"),
        List()));
  }

  Future<Int128> balanceOf(StructTag tokenType) async {
    final struct_tag = StructTag(
        AccountAddress(Helpers.hexToBytes("00000000000000000000000000000001")),
        Identifier("Account"),
        Identifier("Balance"),
        List.from([TypeTagStructItem(tokenType)]));
    final path = List<int>();
    path.add(RESOURCE_TAG);

    final hash = lcsHash(struct_tag.lcsSerialize(), "LIBRA::StructTag");
    path.addAll(hash);

    final result = await getState(Uint8List.fromList(path));
    final balanceResource =
        BalanceResource.lcsDeserialize(Uint8List.fromList(result));
    return balanceResource.token;
  }

  Future<List<int>> getState(Uint8List path) async {
    final jsonRpc = StarcoinClient(url, Client());

    final sender = AccountAddress(this.keyPair.getAddressBytes());
    final accessPath = AccessPath(sender, Bytes(Uint8List.fromList(path)));

    final result = await jsonRpc.makeRPCCall(
        'state_hex.get', [Helpers.byteToHex(accessPath.lcsSerialize())]);

    final listInt = List<int>();
    for (var i in result) {
      listInt.add(i);
    }

    return listInt;
  }

  Future<bool> transferSTC(
    Int128 amount,
    AccountAddress reciever,
  ) async {
    AccountAddress sender = AccountAddress(this.keyPair.getAddressBytes());
    final client = StarcoinClient(url, Client());

    final node_info_result = await client.makeRPCCall('node.info');
    if (node_info_result is Error || node_info_result is Exception)
      throw node_info_result;

    final struct_tag = StructTag(
        AccountAddress(Helpers.hexToBytes("00000000000000000000000000000001")),
        Identifier("STC"),
        Identifier("STC"),
        List());

    var transfer_script = TransactionBuilder.encode_peer_to_peer_script(
        TypeTagStructItem(struct_tag),
        reciever,
        Bytes(Helpers.hexToBytes("703038dffdf4db03ad11fc75cfdec595")),
        amount);

    final seq = await getSeq();
    RawTransaction raw_txn = RawTransaction(
        sender,
        seq,
        TransactionPayloadScriptItem(transfer_script),
        20000,
        1,
        "0x1::STC::STC",
        node_info_result['now'] + 40000,
        ChainId(254));

    var raw_txn_bytes = raw_txn.lcsSerialize();

    log("txn hash is " + Helpers.byteToHex(rawHash(raw_txn_bytes)));

    var sign_bytes = this
        .keyPair
        .sign(cryptHash(raw_txn_bytes, "LIBRA::RawUserTransaction"));

    Ed25519PublicKey pub_key =
        Ed25519PublicKey(Bytes(this.keyPair.getPublicKey()));
    Ed25519Signature sign = Ed25519Signature(Bytes(sign_bytes));

    TransactionAuthenticatorEd25519Item author =
        TransactionAuthenticatorEd25519Item(pub_key, sign);

    SignedUserTransaction signed_txn = SignedUserTransaction(raw_txn, author);
    final result = await client.makeRPCCall('txpool.submit_hex_transaction',
        [Helpers.byteToHex(signed_txn.lcsSerialize())]);

    if (result['Ok'] == null) {
      return true;
    } else {
      log("transfer failed " + result.toString());
      return false;
    }
  }

  Future<int> getSeq() async {
    final client = StarcoinClient(url, Client());

    AccountAddress sender = AccountAddress(this.keyPair.getAddressBytes());

    var struct_tag = StructTag(
        AccountAddress(Helpers.hexToBytes("00000000000000000000000000000001")),
        Identifier("Account"),
        Identifier("Account"),
        List());
    List<int> path = List();
    path.add(RESOURCE_TAG);

    var hash = lcsHash(struct_tag.lcsSerialize(), "LIBRA::StructTag");
    path.addAll(hash);

    AccessPath accessPath = AccessPath(sender, Bytes(Uint8List.fromList(path)));
    var result = await client.makeRPCCall(
        'state_hex.get', [Helpers.byteToHex(accessPath.lcsSerialize())]);

    if (result == null) {
      return 0;
    }
    var list_int = List<int>();
    for (var i in result) {
      list_int.add(i);
    }
    var resource = AccountResource.lcsDeserialize(Uint8List.fromList(list_int));
    return resource.sequence_number;
  }

  @override
  String toString() {
    return getAddress();
  }
}
