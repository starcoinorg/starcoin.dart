import 'dart:typed_data';
import 'package:bech32/bech32.dart';
import 'package:ed25519_dart_base/ed25519_dart.dart' as ed25519_dart;
import 'package:hex/hex.dart';
import 'package:starcoin_wallet/starcoin/starcoin.dart';
import 'package:starcoin_wallet/wallet/helper.dart';
import 'package:sha3/sha3.dart';

String prefix= "stc";
int ACCOUNT_ADDRESS_LEN = 16;

class ReceiptIdentifier {
  AccountAddress accountAddress;
  Uint8List authKey;   
  int version = 1;

  ReceiptIdentifier(this.accountAddress);

  factory ReceiptIdentifier.fromAddressAuthkey(AccountAddress accountAddress,Uint8List authKey){
    var identifier = ReceiptIdentifier(accountAddress);
    identifier.authKey = authKey;
    return identifier;
  }

  factory ReceiptIdentifier.fromHex(String accountAddress,String authKey){    
    var identifier = ReceiptIdentifier(AccountAddress.fromHex(accountAddress));
    identifier.authKey = HEX.decode(authKey.replaceFirst("0x", ""));
    return identifier;
  }

  String encode(){
    var data = List<int>();
    var addressBytes=this.accountAddress.bcsSerialize();
    data.addAll(addressBytes);
    data.addAll(authKey);
    var converted = _convertBits(data, 8, 5, true);
    var fullData = List<int>();
    fullData.add(1);
    fullData.addAll(converted);
    var bech32Data = Bech32(prefix, fullData);
    return bech32.encode(bech32Data);
  }

  factory ReceiptIdentifier.decode(String identifierString){
    var bechData= bech32.decode(identifierString);
    if(bechData.hrp == prefix){
      var data = _convertBits(bechData.data.sublist(1), 5, 8, false);
      var address = AccountAddress(data.sublist(0,ACCOUNT_ADDRESS_LEN));
      var result = ReceiptIdentifier(address);
      if(data.length> ACCOUNT_ADDRESS_LEN){
        var authKey = data.sublist(ACCOUNT_ADDRESS_LEN);
        result.authKey = Uint8List.fromList(authKey);
      }
      return result;
    }else {
      throw Exception("this is not stc ReceiptIdentifier");
    }
  }
}

List<int> _convertBits(List<int> data, int from, int to, bool pad) {
  var acc = 0;
  var bits = 0;
  var result = <int>[];
  var maxv = (1 << to) - 1;

  data.forEach((v) {
    if (v < 0 || (v >> from) != 0) {
      throw Exception();
    }
    acc = (acc << from) | v;
    bits += from;
    while (bits >= to) {
      bits -= to;
      result.add((acc >> bits) & maxv);
    }
  });

  if (pad) {
    if (bits > 0) {
      result.add((acc << (to - bits)) & maxv);
    }
  } else if (bits >= from) {
    throw InvalidPadding('illegal zero padding');
  } else if (((acc << (to - bits)) & maxv) != 0) {
    throw InvalidPadding('non zero');
  }

  return result;
}

class KeyPair {
  Uint8List _privateKey;
  Uint8List _publicKey;

  KeyPair(this._privateKey) {
    _publicKey = ed25519_dart.publicKey(_privateKey);
  }

  String getAddress() {
    var address_bytes = Uint8List.fromList(getAddressBytes());
    return Helpers.byteToHex(address_bytes);
  }

  static String getAddressFromPublicKey(String hexedPk){
    final bytespk=Helpers.hexToBytes(hexedPk);

    List<int> key = new List();
    key.addAll(bytespk);
    key.add(0);

    var k = SHA3(256, SHA3_PADDING, 256);
    k.update(key);
    var hash = k.digest();

    var address_bytes = Uint8List.fromList(hash.sublist(16, 32));
    return Helpers.byteToHex(address_bytes);
  }

  List<int> getAddressBytes() {
    //Uint8List publicKey = ed25519_dart.publicKey(_privateKey);
    List<int> key = new List();
    key.addAll(_publicKey);
    key.add(0);

    var k = SHA3(256, SHA3_PADDING, 256);
    k.update(key);
    var hash = k.digest();
    return hash.sublist(16, 32);
  }

  Uint8List getPublicKey() {
    return _publicKey;
    //return ed25519_dart.publicKey(_privateKey);
  }

  Uint8List getPublicAuthKey() {
    List<int> key = new List();
    key.addAll(_publicKey);
    key.add(0);

    var k = SHA3(256, SHA3_PADDING, 256);
    k.update(key);    
    var hash = k.digest();
    return Uint8List.fromList(hash);
  }

  String getPublicKeyHex() {
    return Helpers.byteToHex(getPublicKey());
  }

  String getPrivateKeyHex() {
    return Helpers.byteToHex(getPrivateKey());
  }

  Uint8List getPrivateKey() {
    return _privateKey;
  }

  ReceiptIdentifier getReceiptIdentifier(){
    return ReceiptIdentifier.fromAddressAuthkey(AccountAddress(this.getAddressBytes()),this.getPublicAuthKey());
  }

  Uint8List sign(Uint8List rawData) {
    //Uint8List salt = Helpers.hexToBytes(HashSaltValues.RawTransactionHashSalt);
    //Uint8List msg = _sha3256.process(Helpers.concat([salt, rawData]));
    //var k = SHA3(256, SHA3_PADDING, 256);
    //k.update(Helpers.concat([salt, rawData]));
    //var hash = k.digest();

    return ed25519_dart.sign(rawData, _privateKey, getPublicKey());
  }

  bool verify(Uint8List signature, Uint8List message) {
    return ed25519_dart.verifySignature(signature, message, getPublicKey());
  }

  KeyPair.fromJson(Map<String, dynamic> json)
      : _privateKey = Helpers.hexToBytes(json['private_key']),
        _publicKey = Helpers.hexToBytes(json['public_key']);

  KeyPair.fromHex(String hexPrivateKey) {
    if (hexPrivateKey.startsWith("0x")) {
      hexPrivateKey = hexPrivateKey.replaceAll("0x", "");
    }
    _privateKey = Helpers.hexToBytes(hexPrivateKey);
    _publicKey = ed25519_dart.publicKey(_privateKey);
  }

  Map<String, dynamic> toJson() => {
        "private_key": getPrivateKeyHex(),
        "public_key": getPublicKeyHex(),
      };
}

Uint8List getAuthKey(Uint8List publicKey) {
  List<int> key = new List();
  key.addAll(publicKey);
  key.add(0);

  var k = SHA3(256, SHA3_PADDING, 256);
  k.update(key);
  var hash = k.digest();
  return Uint8List.fromList(hash);
}
