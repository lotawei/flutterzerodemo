import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterzerodemo/pages/envreplace.dart';
import 'package:flutterzerodemo/pages/voting_page.dart';
import 'package:flutterzerodemo/services/BlockchainService.dart';
import 'package:flutterzerodemo/services/WalletService.dart';
import 'package:web3dart/credentials.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final walletService = WalletService();
  // 这个表示钱包的私钥，请替换成你自己的私钥 这里用的是 npx hardhat node 的第一个账号的地址
  await walletService.savePrivateKey(
     EnvReplace.privateKey
  );
  runApp(MyApp());
  // // lib/main.dart 示例用法

  // final privateKey = await walletService.getPrivateKey();
  // final credentials = await walletService.getCredentials(privateKey!);
  // final contractJson = await rootBundle.loadString(
  //   'blockchain/artifacts/contracts/MyToken.sol/MyToken.json',
  // );
  // final abiContractStrABI = jsonDecode(contractJson);
  // final blockchain = BlockchainService(
  //   abiJson: jsonEncode(abiContractStrABI['abi']),
  //   contractAddress: '0xFABB0ac9d68B0B445fB7357272Ff202C5651694a', // 部署获得的地址
  // );

  // final ethAddress = EthereumAddress.fromHex(
  //   '0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266',
  // );
  // final balance = await blockchain.balanceOf(credentials!.address);
  // print('当前余额: ${balance / BigInt.from(10).pow(18)} MTK');
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '区块链投票系统',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: VotingPage(),
    );
  }
}
