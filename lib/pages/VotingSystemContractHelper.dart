import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../VotingSystem.g.dart';

class VotingSystemContractHelper {
  final Web3Client _client;
  final VotingSystem _contract;
  final EthereumAddress _contractAddress;

  VotingSystemContractHelper._(
    this._client,
    this._contract,
    this._contractAddress,
  );

  /// 创建VotingSystemContractHelper实例
  static Future<VotingSystemContractHelper> create({
    required String rpcUrl,
    required String wsUrl,
    required String contractAddress,
  }) async {
    final client = Web3Client(
      rpcUrl,
      Client(),
      socketConnector: () {
        return WebSocketChannel.connect(Uri.parse(wsUrl)).cast<String>();
      },
    );

    final contractAddr = EthereumAddress.fromHex(contractAddress);
    final contract = VotingSystem(address: contractAddr, client: client);

    return VotingSystemContractHelper._(client, contract, contractAddr);
  }

  /// 创建提案
  Future<String> createProposal({
    required Credentials credentials,
    required String title,
    required String description,
    required BigInt durationInMinutes,
  }) async {
    return _contract.createProposal((
      title: title,
      description: description,
      durationInMinutes: durationInMinutes,
    ), credentials: credentials);
  }

  /// 投票
  Future<String> vote({
    required Credentials credentials,
    required BigInt proposalId,
  }) async {
    return _contract.vote((proposalId: proposalId), credentials: credentials);
  }

  /// 获取提案
  Future<GetProposal> getProposal(BigInt proposalId) async {
    return _contract.getProposal((proposalId: proposalId));
  }

  /// 获取提案数量
  Future<BigInt> getProposalsCount() async {
      return  _contract.getProposalsCount();
  }

  /// 关闭提案
  Future<String> closeProposal({
    required Credentials credentials,
    required BigInt proposalId,
  }) async {
    return _contract.closeProposal((
      proposalId: proposalId,
    ), credentials: credentials);
  }

  /// 监听提案创建事件
  Stream<ProposalCreated> proposalCreatedEvents() {
    return _contract.proposalCreatedEvents();
  }

  /// 监听投票事件
  Stream<Voted> votedEvents() {
    return _contract.votedEvents();
  }

  /// 释放资源
  Future<void> dispose() async {
    await _client.dispose();
  }
}
