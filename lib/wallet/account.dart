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

class TokenBalance {
  StructTag token;
  BigInt balance;

  TokenBalance(this.balance, this.token);
}

class AccountState {
  BigInt balance, sequenceNumber;
  String address;
  String publicKey;
  List<TokenBalance> assets;

  AccountState(
      {BigInt balance,
      BigInt sequenceNumber,
      String address,
      String publicKey,
      List<TokenBalance> assets}) {
    this.balance = balance == null ? BigInt.zero : balance;
    this.sequenceNumber = sequenceNumber == null ? BigInt.zero : sequenceNumber;
    this.address = address;
    this.publicKey = publicKey;
    this.assets = assets;
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
    return await client.getStateJson(sender, path);
  }

  Future<SubmitTransactionResult> sendTransaction(
      String url, TransactionPayload payload) async {
    AccountAddress sender = AccountAddress(this.keyPair.getAddressBytes());
    final client = StarcoinClient(url, Client());

    final nodeInfoResult = await client.makeRPCCall('node.info');

    if (nodeInfoResult is Error || nodeInfoResult is Exception)
      throw nodeInfoResult;

    final seq = await getSeq(url);

    RawTransaction rawTxn = RawTransaction(sender, seq, payload, 20000000, 1,
        "0x1::STC::STC", nodeInfoResult['now_seconds'] + 40000, ChainId(nodeInfoResult['peer_info']['chain_info']['head']['chain_id']));

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

    if (result.toString().substring(2) == txnHash) {
      return SubmitTransactionResult(true, txnHash);
    } else {
      log("transfer failed " + result.toString());
      return SubmitTransactionResult(false, txnHash);
    }
  }

  Future<dynamic> getAccountStateSet(
    String url,
  ) async {
    final client = StarcoinClient(url, Client());

    final sender = AccountAddress(this.keyPair.getAddressBytes());

    final result =
        await client.makeRPCCall('state.get_account_state_set', [sender]);

    return result;
  }

  Future<List<TokenBalance>> getAccountToken(
    String url,
  ) async {
    final accountStateSet = await getAccountStateSet(url);

    final result = List<TokenBalance>();
    if (accountStateSet != null) {
      final resources = accountStateSet['resources'];
      for (var k in resources.keys) {
        if (k.toString().contains("Balance")) {
          final keyString = k.toString();
          final token = parseKeyToSructTag(keyString);
          final value = resources[k]['value'][0] as List;
          final balance = this.parseBalance(value);
          result.add(TokenBalance(balance, token));
        }
      }
    }
    return result;
  }

  BigInt parseBalance(List value) {
    for (var item in value) {
      if (item is Map) {
        final balanceValue = item['Struct']['value'][0];
        for (var balance in balanceValue) {
          if (balance is Map) {
            return BigInt.parse(balance['U128']);
          }
        }
      }
    }
    throw new Exception("can't parse balance");
  }

  StructTag parseKeyToSructTag(String key) {
    final tokens = key.split("::");
    if (tokens.length == 5) {
      final address = AccountAddress.fromHex(tokens[0]);
      final tokenThreeTokens = tokens[2].split("<");
      final paramStruct = StructTag(AccountAddress.fromHex(tokenThreeTokens[1]),
          Identifier(tokens[3]), Identifier(tokens[4].replaceAll(">", "")), []);
      final params = TypeTagStructItem(paramStruct);
      final result = StructTag(address, Identifier(tokens[1]),
          Identifier(tokenThreeTokens[0]), [params]);
      return result;
    }
    return null;
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

    return await transferToken(url, amount, reciever, publicKey, structTag);
  }

  Future<SubmitTransactionResult> transferToken(String url, Int128 amount,
      AccountAddress reciever, Bytes publicKey, StructTag structTag) async {
    var transferScript = TransactionBuilder.encode_peer_to_peer_script_function(
        TypeTagStructItem(structTag), reciever, publicKey, amount);

    return await sendTransaction(
        url, transferScript);
  }

  Future<int> getSeq(String url) async {
    var structTag = StructTag(
        AccountAddress(Helpers.hexToBytes("00000000000000000000000000000001")),
        Identifier("Account"),
        Identifier("Account"),
        List());

    final result = await this.getState(url, DataPathResourceItem(structTag));

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
