import 'package:flutter_test/flutter_test.dart';
import 'package:starcoin_wallet/wallet.dart';
import 'package:starcoin_wallet/account.dart';
import 'package:starcoin_wallet/helper.dart';
import 'dart:typed_data';

const String mnemonic =
    'danger gravity economy coconut flavor cart relax cactus analyst cradle pelican guitar balance there mail check where scrub topple shock connect valid follow flip';
const address1 =
    '6b68105b99cc381e9b4c8a9067fff4e204e1ce0384e2c0ce095321ed8a50e57b';
const address2 =
    'e7f884d74d8372becba990f374bb92a3edd19be9d8d1e50cac38c79d6f57d1c0';

void main() {
  test('wallet test', () {
    Wallet wallet = new Wallet(mnemonic: mnemonic, salt: 'LIBRA');
    Account account = wallet.newAccount();
    print(Helpers.byteToHex(account.keyPair.getPrivateKey()));
    print(Helpers.byteToHex(account.keyPair.getPublicKey()));
    expect("7d43d5269ddb89cdb7f7b812689bf135", account.getAddress());

    var message = Uint8List.fromList([1, 2, 3, 4]);
    var result = account.keyPair.sign(message);
    print("result is " + Helpers.byteToHex(result));
    expect(Helpers.byteToHex(result),
        "329675b43134113a079c6c61290c685780cb15959af6d0f144ec846d88456be0e66b4e830bdf6695de43769c344bd6769a186b4446de62693d5032e9daabf901");
    expect(account.keyPair.verify(result, message), true);
  });
}
