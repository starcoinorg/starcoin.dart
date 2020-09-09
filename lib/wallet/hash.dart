import 'package:sha3/sha3.dart';
import 'dart:typed_data';

Uint8List lcsHash(Uint8List rawData, String seedPrefix) {
  var k = SHA3(256, SHA3_PADDING, 256);
  k.update(Uint8List.fromList(seedPrefix.codeUnits));
  var hash = k.digest();

  k = SHA3(256, SHA3_PADDING, 256);
  k.update(Uint8List.fromList(hash));
  k.update(rawData);
  hash = k.digest();
  return Uint8List.fromList(hash);
}

Uint8List cryptHash(Uint8List rawBytes, String seedPrefix) {
  List<int> rawData = List<int>();
  var k = SHA3(256, SHA3_PADDING, 256);
  k.update(Uint8List.fromList(seedPrefix.codeUnits));
  var salt = k.digest();
  rawData.addAll(salt);
  rawData.addAll(rawBytes);
  return Uint8List.fromList(rawData);
}

Uint8List rawHash(Uint8List txn) {
  var k = SHA3(256, SHA3_PADDING, 256);
  k.update(txn);
  var hash = k.digest();
  return Uint8List.fromList(hash);
}
