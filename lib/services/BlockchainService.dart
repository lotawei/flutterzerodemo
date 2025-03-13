import 'package:flutterzerodemo/pages/envreplace.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart' as http;

import 'TimeOutClient.dart';

class TokenERC20Service {

  // 注意根据运行环境调整IP (Android模拟器需使用10.0.2.2)
  static  String rpcUrl = EnvReplace.localhost;
  static final httpClient = TimeoutClient(http.Client(), Duration(seconds: 30));
  // 创建 Web3Client 实例，并将 http.Client 传递给它
  // 强烈建议设置超时参数
  static final client = Web3Client(rpcUrl,httpClient );
  final ContractAbi _contractAbi;
  final EthereumAddress _contractAddress;
  TokenERC20Service({required String abiJson, required String contractAddress})
    : _contractAbi = ContractAbi.fromJson(abiJson, "MyToken"),
      _contractAddress = EthereumAddress.fromHex(contractAddress);
  Future<DeployedContract> _getDeployedContract() async {
    return DeployedContract(_contractAbi, _contractAddress);
  }

  // 发送交易(需签名)
  Future<String> transfer({
    required Credentials sender,
    required EthereumAddress to,
    required BigInt amount,
  }) async {
    final contract = await _getDeployedContract();
    final func = contract.function("transfer");

    final transaction = Transaction.callContract(
      contract: contract,
      function: func,
      parameters: [to, amount],
      from: sender.address,
    );

    return await client.sendTransaction(
      sender,
      transaction,
      chainId: 1337, // 本地链ID
    );
  }

  // 查询代币余额
  Future<BigInt> balanceOf(EthereumAddress address) async {
    final contract = await _getDeployedContract();
    final func = contract.function("balanceOf");
    final result = await client.call(
      contract: contract,
      function: func,
      params: [address],
    );
    return result.first as BigInt;
  }
}
