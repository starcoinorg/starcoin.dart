import 'package:flutter_test/flutter_test.dart';
import 'package:starcoin_wallet/starcoin/starcoin.dart';
import 'package:starcoin_wallet/serde/serde.dart';

import 'package:starcoin_wallet/wallet/wallet.dart';
import 'package:starcoin_wallet/wallet/account.dart';
import 'package:starcoin_wallet/wallet/helper.dart';
import 'package:starcoin_wallet/transaction_builder.dart';
import 'dart:typed_data';
import 'package:json_rpc_2/json_rpc_2.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:pedantic/pedantic.dart';
import 'package:starcoin_wallet/wallet/hash.dart';

const String mnemonic =
    'danger gravity economy coconut flavor cart relax cactus analyst cradle pelican guitar balance there mail check where scrub topple shock connect valid follow flip';
const address1 =
    '6b68105b99cc381e9b4c8a9067fff4e204e1ce0384e2c0ce095321ed8a50e57b';
const address2 =
    'e7f884d74d8372becba990f374bb92a3edd19be9d8d1e50cac38c79d6f57d1c0';
const RESOURCE_TAG = 1;

void main() {
  test('wallet test', () {
    Wallet wallet = new Wallet(mnemonic: mnemonic, salt: 'LIBRA');
    Account account = wallet.newAccount();
    //print(Helpers.byteToHex(account.keyPair.getPrivateKey()));
    var public_key_hex = Helpers.byteToHex(account.keyPair.getPublicKey());
    //print("public key is $public_key_hex");
    expect("7d43d5269ddb89cdb7f7b812689bf135", account.getAddress());

    var message = Uint8List.fromList([1, 2, 3, 4]);
    var result = account.keyPair.sign(message);
    //print("result is " + Helpers.byteToHex(result));
    expect(Helpers.byteToHex(result),
        "329675b43134113a079c6c61290c685780cb15959af6d0f144ec846d88456be0e66b4e830bdf6695de43769c344bd6769a186b4446de62693d5032e9daabf901");
    expect(account.keyPair.verify(result, message), true);
  });

  test('call tx pool', () async {
    var socket = WebSocketChannel.connect(Uri.parse('ws://127.0.0.1:9870'));
    var client = Client(socket.cast<String>());

    unawaited(client.listen());

    var node_info = await client.sendRequest('node.info');

    //var txpool_state = await client.sendRequest('txpool.state');
    //print('txpool state is $txpool_state');

    Wallet wallet = new Wallet(mnemonic: mnemonic, salt: 'LIBRA');
    Account account = wallet.newAccount();
    AccountAddress sender = AccountAddress(account.keyPair.getAddressBytes());

    var struct_tag = StructTag(
        AccountAddress(Helpers.hexToBytes("00000000000000000000000000000001")),
        Identifier("Account"),
        Identifier("Account"),
        List());
    List<int> path = List();
    path.add(RESOURCE_TAG);

    var hash = lcsHash(struct_tag.lcsSerialize(), "LIBRA::StructTag");
    path.addAll(hash);

    //var hex_access_path = Helpers.byteToHex(Uint8List.fromList(path));
    //print("hash is " + hex_access_path);
    AccessPath accessPath = AccessPath(sender, Bytes(Uint8List.fromList(path)));
    var result = await client.sendRequest(
        'state_hex.get', [Helpers.byteToHex(accessPath.lcsSerialize())]);

    var list_int = List<int>();
    for (var i in result) {
      list_int.add(i);
    }
    var resource = AccountResource.lcsDeserialize(Uint8List.fromList(list_int));
    print("resouce is " + resource.sequence_number.toString());

    var empty_script = TransactionBuilder.encode_empty_script_script();
    struct_tag = StructTag(
        AccountAddress(Helpers.hexToBytes("00000000000000000000000000000001")),
        Identifier("STC"),
        Identifier("STC"),
        List());
    var transfer_script = TransactionBuilder.encode_peer_to_peer_script(
        TypeTagStructItem(struct_tag),
        AccountAddress(
            (Helpers.hexToBytes("703038dffdf4db03ad11fc75cfdec595"))),
        Bytes(Helpers.hexToBytes("703038dffdf4db03ad11fc75cfdec595")),
        Int128(0, 200));

    RawTransaction raw_txn = RawTransaction(
        sender,
        resource.sequence_number,
        TransactionPayloadScriptItem(transfer_script),
        20000,
        1,
        "0x1::STC::STC",
        node_info['now'] + 40000,
        ChainId(254));

    var raw_txn_bytes = raw_txn.lcsSerialize();

    print("txn hash is " + Helpers.byteToHex(rawHash(raw_txn_bytes)));

    var sign_bytes = account.keyPair
        .sign(cryptHash(raw_txn_bytes, "LIBRA::RawUserTransaction"));

    Ed25519PublicKey pub_key =
        Ed25519PublicKey(Bytes(account.keyPair.getPublicKey()));
    Ed25519Signature sign = Ed25519Signature(Bytes(sign_bytes));

    TransactionAuthenticatorEd25519Item author =
        TransactionAuthenticatorEd25519Item(pub_key, sign);

    SignedUserTransaction signed_txn = SignedUserTransaction(raw_txn, author);
    result = await client.sendRequest('txpool.submit_hex_transaction',
        [Helpers.byteToHex(signed_txn.lcsSerialize())]);
    print('result is $result');
  });
}
