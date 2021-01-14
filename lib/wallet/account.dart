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
import 'package:starcoin_wallet/wallet/wallet_client.dart';

const RESOURCE_TAG = 1;

const SENDSALT = 0;
const RECVSALT = 1;

class AccountState {
  BigInt balance, sequenceNumber;
  String address;
  String publicKey;

  AccountState({
    BigInt balance,
    BigInt sequenceNumber,
    String address,
    String publicKey,
  }) {
    this.balance = balance == null ? BigInt.zero : balance;
    this.sequenceNumber = sequenceNumber == null ? BigInt.zero : sequenceNumber;
    this.address = address;
    this.publicKey = publicKey;
  }
}

class SubmitTransactionResult {
  bool result;
  String txnHash;

  SubmitTransactionResult(bool result, String txnHash) {
    this.result = result;
    this.txnHash = txnHash;
  }

  @override
  String toString() {
    return "result is $result, txnHash is $txnHash";
  }
}

class Account {
  KeyPair keyPair;
  String _address;

  Account(KeyPair keyPair) {
    this.keyPair = keyPair;
  }

  static Account fromPrivateKey(Uint8List privateKey) {
    return new Account(new KeyPair(privateKey));
  }

  String getAddress() {
    if (_address != null && _address.isNotEmpty) {
      return "0x" + _address;
    }
    _address = keyPair.getAddress();
    return "0x" + _address;
  }

  Future<Int128> balanceOfStc(String url) async {
    return await balanceOf(
        url,
        StructTag(
            AccountAddress(
                Helpers.hexToBytes("00000000000000000000000000000001")),
            Identifier("STC"),
            Identifier("STC"),
            List()));
  }

  Future<Int128> balanceOf(String url, StructTag tokenType) async {
    final structTag = StructTag(
        AccountAddress(Helpers.hexToBytes("00000000000000000000000000000001")),
        Identifier("Account"),
        Identifier("Balance"),
        List.from([TypeTagStructItem(tokenType)]));
    final path = List<int>();
    path.add(RESOURCE_TAG);

    final hash = lcsHash(structTag.bcsSerialize(), "STARCOIN::StructTag");
    path.addAll(hash);

    final result = await getState(url, DataPathResourceItem(structTag));

    if (result == null) {
      return Int128(0, 0);
    }
    final balanceResource =
        BalanceResource.bcsDeserialize(Uint8List.fromList(result));
    return balanceResource.token;
  }

  Future<List<int>> getState(String url, DataPath path) async {
    final client = WalletClient(url);

    final sender = AccountAddress(this.keyPair.getAddressBytes());
    return await client.getState(sender, path);
  }

  Future<SubmitTransactionResult> sendTransaction(
      String url, TransactionPayload payload) async {
    AccountAddress sender = AccountAddress(this.keyPair.getAddressBytes());
    final client = StarcoinClient(url, Client());

    final nodeInfoResult = await client.makeRPCCall('node.info');
    if (nodeInfoResult is Error || nodeInfoResult is Exception)
      throw nodeInfoResult;

    final seq = await getSeq(url);

    RawTransaction rawTxn = RawTransaction(sender, seq, payload, 20000, 1,
        "0x1::STC::STC", nodeInfoResult['now_seconds'] + 40000, ChainId(254));

    var rawTxnBytes = rawTxn.bcsSerialize();

    //print("raw_txn_bytes is $raw_txn_bytes");

    var signBytes = this
        .keyPair
        .sign(cryptHash(rawTxnBytes, "STARCOIN::RawUserTransaction"));

    Ed25519PublicKey pubKey =
        Ed25519PublicKey(Bytes(this.keyPair.getPublicKey()));
    Ed25519Signature sign = Ed25519Signature(Bytes(signBytes));

    TransactionAuthenticatorEd25519Item author =
        TransactionAuthenticatorEd25519Item(pubKey, sign);

    SignedUserTransaction signedTxn = SignedUserTransaction(rawTxn, author);

    final txnHash = Helpers.byteToHex(
        lcsHash(signedTxn.bcsSerialize(), "STARCOIN::SignedUserTransaction"));

    final result = await client.makeRPCCall('txpool.submit_hex_transaction',
        [Helpers.byteToHex(signedTxn.bcsSerialize())]);

    if (result == null) {
      return SubmitTransactionResult(true, txnHash);
    } else {
      log("transfer failed " + result.toString());
      return SubmitTransactionResult(false, txnHash);
    }
  }

  Future<SubmitTransactionResult> transferSTC(
    String url,
    Int128 amount,
    AccountAddress reciever,
    Bytes publicKey,
  ) async {
    final structTag = StructTag(
        AccountAddress(Helpers.hexToBytes("00000000000000000000000000000001")),
        Identifier("STC"),
        Identifier("STC"),
        List());

    var transferScript = TransactionBuilder.encode_peer_to_peer_script(
        TypeTagStructItem(structTag), reciever, publicKey, amount);

    return await sendTransaction(
        url, TransactionPayloadScriptItem(transferScript));
  }

  Future<int> getSeq(String url) async {
    final client = StarcoinClient(url, Client());

    AccountAddress sender = AccountAddress(this.keyPair.getAddressBytes());

    var structTag = StructTag(
        AccountAddress(Helpers.hexToBytes("00000000000000000000000000000001")),
        Identifier("Account"),
        Identifier("Account"),
        List());
    List<int> path = List();
    path.add(RESOURCE_TAG);

    var hash = lcsHash(structTag.bcsSerialize(), "STARCOIN::StructTag");
    path.addAll(hash);

    AccessPath accessPath = AccessPath(sender, DataPathResourceItem(structTag));
    var result = await client.makeRPCCall(
        'state_hex.get', [Helpers.byteToHex(accessPath.bcsSerialize())]);

    if (result == null) {
      return 0;
    }
    var listInt = List<int>();
    for (var i in result) {
      listInt.add(i);
    }
    var resource = AccountResource.bcsDeserialize(Uint8List.fromList(listInt));
    return resource.sequence_number;
  }

  EventKey sendEventKey() {
    return genEventKey(SENDSALT);
  }

  EventKey recvEventKey() {
    return genEventKey(RECVSALT);
  }

  EventKey genEventKey(int salt) {
    AccountAddress self = AccountAddress(this.keyPair.getAddressBytes());
    List<int> result = List<int>();

    var bdata = new ByteData(8);
    bdata.setUint64(0, salt, Endian.little);
    result.addAll(bdata.buffer.asUint8List());
    result.addAll(self.value);

    return EventKey(Bytes(Uint8List.fromList(result)));
  }

  @override
  String toString() {
    return getAddress();
  }
}
