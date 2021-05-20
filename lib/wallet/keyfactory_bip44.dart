import 'package:starcoin_wallet/wallet/keypair.dart';
import 'package:starcoin_wallet/wallet/mnemonic.dart';
import 'package:bip32/bip32.dart' as bip32;
import 'package:bip39/bip39.dart' as bip39;

class KeyFactory {

  bip32.BIP32 node;
  String path = "m/44'/60'/0'/0/";

  KeyFactory(String salt, {String mnemonic}) {
    if (mnemonic != null && mnemonic.isNotEmpty) {
      assert(Mnemonic.validateMnemonic(mnemonic));
    } else {
      mnemonic = Mnemonic.generateMnemonic();
    }
    var seed =  bip39.mnemonicToSeed(mnemonic);

    node = bip32.BIP32.fromSeed(seed);
  }

  KeyPair generateKey(int childDepth) {
    var child=node.derivePath(path+childDepth.toString());
    return KeyPair(child.privateKey);
  }

}
