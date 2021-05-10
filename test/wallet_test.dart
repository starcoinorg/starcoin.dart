import 'dart:collection';

import 'package:flutter_test/flutter_test.dart';
import 'package:optional/optional.dart';
import 'package:starcoin_wallet/starcoin/starcoin.dart';
import 'package:starcoin_wallet/serde/serde.dart';
import 'package:starcoin_wallet/wallet/host_manager.dart';
import 'package:starcoin_wallet/wallet/json_rpc.dart';

import 'package:starcoin_wallet/wallet/account_manager.dart';
import 'package:starcoin_wallet/wallet/keypair.dart';
import 'package:starcoin_wallet/wallet/node.dart';
import 'package:starcoin_wallet/wallet/wallet_client.dart';
import 'package:starcoin_wallet/wallet/account.dart';
import 'package:starcoin_wallet/wallet/helper.dart';
import 'package:starcoin_wallet/transaction_builder.dart';
import 'dart:typed_data';
import 'package:json_rpc_2/json_rpc_2.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:pedantic/pedantic.dart';
import 'package:starcoin_wallet/wallet/hash.dart';
import 'dart:async';
import 'package:starcoin_wallet/wallet/pubsub.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/io.dart';

const String mnemonic =
    'danger gravity economy coconut flavor cart relax cactus analyst cradle pelican guitar balance there mail check where scrub topple shock connect valid follow flip';
const address1 =
    '6b68105b99cc381e9b4c8a9067fff4e204e1ce0384e2c0ce095321ed8a50e57b';
const address2 =
    'e7f884d74d8372becba990f374bb92a3edd19be9d8d1e50cac38c79d6f57d1c0';
const URL = "http://127.0.0.1:9850";

HostMananger localHostManager(){
  var hosts = HashSet<String>();
  hosts.add("localhost");
  var hostManager = SimpleHostManager(hosts);
  return hostManager;
}

void main() {
  test('wallet test', () {
    Wallet wallet = new Wallet(mnemonic: mnemonic, salt: 'LIBRA');
    Account account = wallet.newAccount();
    print(Helpers.byteToHex(account.keyPair.getPrivateKey()));
    var public_key_hex = Helpers.byteToHex(account.keyPair.getPublicKey());
    print("public key is $public_key_hex");
    expect("0x7d43d5269ddb89cdb7f7b812689bf135", account.getAddress());

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

    Wallet wallet = new Wallet(mnemonic: mnemonic, salt: 'LIBRA',hostMananger: localHostManager());
    Account account = wallet.newAccount();
    AccountAddress sender = AccountAddress(account.keyPair.getAddressBytes());

    var struct_tag = StructTag(
        AccountAddress(Helpers.hexToBytes("00000000000000000000000000000001")),
        Identifier("Account"),
        Identifier("Account"),
        List());
    List<int> path = List();
    path.add(RESOURCE_TAG);

    var hash = lcsHash(struct_tag.bcsSerialize(), "STARCOIN::StructTag");
    path.addAll(hash);

    final walletClient = new WalletClient(URL);
    var result = await walletClient.getStateJson(
        sender, DataPathResourceItem(struct_tag));

    var list_int = List<int>();
    for (var i in result) {
      list_int.add(i);
    }
    var resource = AccountResource.bcsDeserialize(Uint8List.fromList(list_int));
    print("resouce is " + resource.sequence_number.toString());

    struct_tag = StructTag(
        AccountAddress(Helpers.hexToBytes("00000000000000000000000000000001")),
        Identifier("Account"),
        Identifier("Balance"),
        List.from([
          TypeTagStructItem(StructTag(
              AccountAddress(
                  Helpers.hexToBytes("00000000000000000000000000000001")),
              Identifier("STC"),
              Identifier("STC"),
              List()))
        ]));
    path = List();
    path.add(RESOURCE_TAG);

    hash = lcsHash(struct_tag.bcsSerialize(), "STARCOIN::StructTag");
    path.addAll(hash);

    //var hex_access_path = Helpers.byteToHex(Uint8List.fromList(path));
    //print("hash is " + hex_access_path);
    //var accessPath = AccessPath(sender, DataPathResourceItem(struct_tag));
    result = await walletClient.getStateJson(
        sender, DataPathResourceItem(struct_tag));
    list_int = List<int>();
    for (var i in result) {
      list_int.add(i);
    }
    var balanceResource =
        BalanceResource.bcsDeserialize(Uint8List.fromList(list_int));
    print("balance is " + balanceResource.token.low.toString());

    //var empty_script = TransactionBuilder.en();
    struct_tag = StructTag(
        AccountAddress(Helpers.hexToBytes("00000000000000000000000000000001")),
        Identifier("STC"),
        Identifier("STC"),
        List());
    var transfer_script = TransactionBuilder.encode_peer_to_peer_script_function(
        TypeTagStructItem(struct_tag),
        AccountAddress(
            (Helpers.hexToBytes("703038dffdf4db03ad11fc75cfdec595"))),
        Bytes(Helpers.hexToBytes("826cf2fd51e9fa87378d385c347599f609457b466bcb97d81e22608247440c8f")),
        Int128(0, 200));
    var payload_bytes = transfer_script.bcsSerialize();
    print("payload is "+Helpers.byteToHex(payload_bytes));  


    RawTransaction raw_txn = RawTransaction(
        sender,
        resource.sequence_number,
        transfer_script,
        20000,
        1,
        "0x1::STC::STC",
        node_info['now_seconds'] + 40000,
        ChainId(254));

    var raw_txn_bytes = raw_txn.bcsSerialize();
    print("txn is "+Helpers.byteToHex(raw_txn_bytes));  
    print("txn hash is " + Helpers.byteToHex(rawHash(raw_txn_bytes)));

    var sign_bytes = account.keyPair
        .sign(cryptHash(raw_txn_bytes, "STARCOIN::RawUserTransaction"));

    Ed25519PublicKey pub_key =
        Ed25519PublicKey(Bytes(account.keyPair.getPublicKey()));
    Ed25519Signature sign = Ed25519Signature(Bytes(sign_bytes));

    TransactionAuthenticatorEd25519Item author =
        TransactionAuthenticatorEd25519Item(pub_key, sign);

    SignedUserTransaction signed_txn = SignedUserTransaction(raw_txn, author);

    var res = await client.sendRequest('txpool.submit_hex_transaction',
        [Helpers.byteToHex(signed_txn.bcsSerialize())]);
    print('result is $res');
  });

  test('Account', () async {
    Wallet wallet = new Wallet(mnemonic: mnemonic, salt: 'LIBRA',hostMananger: localHostManager());

    final walletClient = new WalletClient(URL);
    Account account = wallet.newAccount();
    Account reciever = wallet.newAccount();

    final balance = await account.balanceOfStc();
    print("balance is " + balance.low.toString());

    final result = await account.transferSTC(
        Int128(0, 20000),
        AccountAddress(reciever.keyPair.getAddressBytes()),
        Bytes(reciever.keyPair.getPublicAuthKey()));
    print("reciever address is "+reciever.keyPair.getAddressBytes().toString());
    print("reciever public key is "+reciever.keyPair.getPublicAuthKey().toString());
    print("reciever private key is "+reciever.keyPair.getPrivateKeyHex());
    print("result is $result");

    await Future.delayed(Duration(seconds: 5));

    if (result.result == true) {
      final txn = await walletClient.getTransaction(result.txnHash);
      print("txn is $txn");
    }

    if (result.result == true) {
      final txn = await walletClient.getTransactionInfo(result.txnHash);
      print("txn_info is $txn");
    }

    final accountStateSet = await account.getAccountStateSet();
    if (accountStateSet != null) {
      final resources = accountStateSet['resources'];
      for (var k in resources.keys) {
        if (k.toString().contains("Balance")) {
          final value = resources[k]['value'][0] as List;
          for (var item in value) {
            if (item is Map) {
              final balanceValue = item['Struct']['value'][0];
              for (var balance in balanceValue) {
                if (balance is Map) {
                  print(BigInt.parse(balance['U128']));
                }
              }
            }
          }
          print("Key : $k, value : ${value}");
        }
      }
    }

    final tokenList = await account.getAccountToken(URL);
    if(tokenList.length>0){
    final result = await account.transferToken(
        Int128(0, 20000),
        AccountAddress(reciever.keyPair.getAddressBytes()),
        Bytes(reciever.keyPair.getPublicAuthKey()),
        tokenList[0].token
        );        
    }
  });

  test('Account Transfer Token', () async {
    Wallet wallet = new Wallet(mnemonic: mnemonic, salt: 'LIBRA',hostMananger: localHostManager());

    final walletClient = new WalletClient(URL);
    Account account = wallet.newAccount();
    Account reciever = wallet.newAccount();

    final balance = await account.balanceOfStc();
    print("balance is " + balance.low.toString());

    final tokenList = await account.getAccountToken(URL);
    if(tokenList.length>0){      
      var sruct_tag=tokenList[0].token.type_params[0] as TypeTagStructItem;
      final result = await account.transferToken(
        Int128(0, 20000),
        AccountAddress(reciever.keyPair.getAddressBytes()),
        Bytes(reciever.keyPair.getPublicAuthKey()),
        sruct_tag.value
        );        
    
      await Future.delayed(Duration(seconds: 5));

      if (result.result == true) {
        final txn = await walletClient.getTransaction(result.txnHash);
        print("txn is $txn");
      }

      if (result.result == true) {
        final txn = await walletClient.getTransactionInfo(result.txnHash);
        print("txn_info is $txn");
      }
    
    }
  });

  test('sub', () async {
    var socket = IOWebSocketChannel.connect(Uri.parse('ws://127.0.0.1:9870'));
    var rpc = JsonRPC("http://127.0.0.1:9850", http.Client());
    var client = PubSubClient(socket.cast<String>(), rpc);
    final walletClient = new WalletClient(URL);
    Wallet wallet = new Wallet(mnemonic: mnemonic, salt: 'LIBRA',hostMananger: localHostManager());

    final account = wallet.newAccount();

    var subscription = client.addFilter(NewTxnSendRecvEventFilter(account));

    await for (var event in subscription) {
      print(await walletClient.getTransactionInfo(event['transaction_hash']));
      print(await walletClient.getTransaction(event['transaction_hash']));
      break;
    }
  });

  test('node', () async {
    final node = Node("http://127.0.0.1:9850");
    final result = await node.defaultAccount();
    print(result);

    final List exportedAccount =
        await node.exportAccount(result['address'], "");
    print(KeyPair(
            Uint8List.fromList(exportedAccount.map((e) => e as int).toList()))
        .getPrivateKeyHex());

    final address =
        AccountAddress.fromJson(result['address'].replaceAll("0x", ""));
    final balance = await node.balanceOfStc(address);
    print(balance.toBigInt());

    final nodeInfo = await node.nodeInfo();
    print(nodeInfo['peer_info']['chain_info']['total_difficulty']);

    final syncStatus = await node.syncStatus();
    print(syncStatus);

    //final syncProgress = await node.syncProgress();
    //final taskNames = syncProgress['current']['task_name'].split("::");
    //print(taskNames[taskNames.length - 1]);

    //final double percent = syncProgress['current']['percent'];
    //print(percent);
  });

  test('events', () async {
    Wallet wallet = new Wallet(mnemonic: mnemonic, salt: 'LIBRA',hostMananger: localHostManager());

    final walletClient = new WalletClient(URL);
    final account = wallet.newAccount();

    final txnList = await walletClient.getTxnList(
        account, Optional.of(0), Optional.empty(), Optional.empty());
    print(txnList[0].txn);
    print(txnList[0].txnInfo);

    final batchClient = new BatchClient('ws://127.0.0.1:9870');
    final txnList2 = await batchClient.getTxnListBatch(walletClient, account,
        Optional.of(0), Optional.empty(), Optional.empty());
    print(txnList2[0].txn);
    print(txnList2[0].txnInfo);
  });

  test('Hash', () {
    final bytes = Uint8List.fromList([
      125,
      67,
      213,
      38,
      157,
      219,
      137,
      205,
      183,
      247,
      184,
      18,
      104,
      155,
      241,
      53,
      7,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      161,
      1,
      161,
      28,
      235,
      11,
      1,
      0,
      0,
      0,
      6,
      1,
      0,
      2,
      3,
      2,
      17,
      4,
      19,
      4,
      5,
      23,
      24,
      7,
      47,
      42,
      8,
      89,
      16,
      0,
      0,
      0,
      1,
      0,
      1,
      1,
      1,
      0,
      2,
      2,
      3,
      0,
      0,
      3,
      4,
      1,
      1,
      1,
      0,
      6,
      2,
      6,
      2,
      5,
      10,
      2,
      0,
      1,
      5,
      1,
      1,
      3,
      6,
      12,
      5,
      4,
      4,
      6,
      12,
      5,
      10,
      2,
      4,
      1,
      9,
      0,
      7,
      65,
      99,
      99,
      111,
      117,
      110,
      116,
      14,
      99,
      114,
      101,
      97,
      116,
      101,
      95,
      97,
      99,
      99,
      111,
      117,
      110,
      116,
      9,
      101,
      120,
      105,
      115,
      116,
      115,
      95,
      97,
      116,
      8,
      112,
      97,
      121,
      95,
      102,
      114,
      111,
      109,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      1,
      1,
      1,
      5,
      1,
      13,
      10,
      1,
      17,
      1,
      32,
      3,
      5,
      5,
      8,
      10,
      1,
      10,
      2,
      56,
      0,
      11,
      0,
      10,
      1,
      10,
      3,
      56,
      1,
      2,
      1,
      7,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      1,
      3,
      83,
      84,
      67,
      3,
      83,
      84,
      67,
      0,
      3,
      3,
      170,
      98,
      21,
      247,
      38,
      8,
      228,
      209,
      97,
      153,
      20,
      39,
      180,
      155,
      110,
      103,
      4,
      16,
      112,
      48,
      56,
      223,
      253,
      244,
      219,
      3,
      173,
      17,
      252,
      117,
      207,
      222,
      197,
      149,
      2,
      200,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      32,
      78,
      0,
      0,
      0,
      0,
      0,
      0,
      1,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      13,
      48,
      120,
      49,
      58,
      58,
      83,
      84,
      67,
      58,
      58,
      83,
      84,
      67,
      5,
      226,
      96,
      95,
      0,
      0,
      0,
      0,
      254,
      0,
      32,
      130,
      108,
      242,
      253,
      81,
      233,
      250,
      135,
      55,
      141,
      56,
      92,
      52,
      117,
      153,
      246,
      9,
      69,
      123,
      70,
      107,
      203,
      151,
      216,
      30,
      34,
      96,
      130,
      71,
      68,
      12,
      143,
      64,
      6,
      102,
      250,
      227,
      98,
      221,
      129,
      136,
      197,
      243,
      79,
      206,
      201,
      57,
      0,
      57,
      163,
      216,
      146,
      36,
      227,
      205,
      214,
      21,
      85,
      200,
      71,
      42,
      155,
      16,
      207,
      204,
      134,
      183,
      87,
      89,
      253,
      28,
      178,
      254,
      244,
      28,
      94,
      129,
      152,
      49,
      111,
      118,
      238,
      236,
      36,
      49,
      239,
      179,
      197,
      211,
      150,
      199,
      7,
      37,
      161,
      6,
      202,
      7
    ]);
    expect("6b4ddb8ee36850cf6dbaf1826031d47cefb4bb217b9735f0dfa3d42cca7f4938",
        Helpers.byteToHex(lcsHash(bytes, "LIBRA::SignedUserTransaction")));
  });
}
