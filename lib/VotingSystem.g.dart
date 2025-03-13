// @dart=3.0
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_local_variable, unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark
// ignore_for_file: no_leading_underscores_for_library_prefixes
// 步骤 npx hardhat compile 后会生成 abi.json 文件
// 拷贝 abi.json 到lib/ 文件下
//  npx  hardhat run scripts/deployVoting.ts --network localhost  部署合约
//  console.log(`VotingSystem Contract deployed to: ${await votingSystem.getAddress()}`);
// 获取到部署合约地址

//  该文件自动生成的 使用  flutter  pub run build_runner build  前提 abi.json 放在lib/ 下面的
//  运行该命令后会在lib/生成g.dart文件，该文件包含了合约的abi信息，可以直接使用



import 'package:web3dart/web3dart.dart' as _i1;


final _contractAbi = _i1.ContractAbi.fromJson(
  '[{"inputs":[],"stateMutability":"nonpayable","type":"constructor"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"uint256","name":"proposalId","type":"uint256"},{"indexed":false,"internalType":"string","name":"title","type":"string"},{"indexed":false,"internalType":"uint256","name":"endTime","type":"uint256"}],"name":"ProposalCreated","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"address","name":"voter","type":"address"},{"indexed":false,"internalType":"uint256","name":"proposalId","type":"uint256"}],"name":"Voted","type":"event"},{"inputs":[{"internalType":"uint256","name":"_proposalId","type":"uint256"}],"name":"closeProposal","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"string","name":"_title","type":"string"},{"internalType":"string","name":"_description","type":"string"},{"internalType":"uint256","name":"_durationInMinutes","type":"uint256"}],"name":"createProposal","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"uint256","name":"_proposalId","type":"uint256"}],"name":"getProposal","outputs":[{"internalType":"string","name":"title","type":"string"},{"internalType":"string","name":"description","type":"string"},{"internalType":"uint256","name":"voteCount","type":"uint256"},{"internalType":"uint256","name":"endTime","type":"uint256"},{"internalType":"bool","name":"isActive","type":"bool"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"getProposalsCount","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"owner","outputs":[{"internalType":"address","name":"","type":"address"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint256","name":"","type":"uint256"}],"name":"proposals","outputs":[{"internalType":"string","name":"title","type":"string"},{"internalType":"string","name":"description","type":"string"},{"internalType":"uint256","name":"voteCount","type":"uint256"},{"internalType":"uint256","name":"endTime","type":"uint256"},{"internalType":"bool","name":"isActive","type":"bool"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint256","name":"_proposalId","type":"uint256"}],"name":"vote","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"","type":"address"},{"internalType":"uint256","name":"","type":"uint256"}],"name":"votes","outputs":[{"internalType":"bool","name":"hasVoted","type":"bool"},{"internalType":"uint256","name":"proposalId","type":"uint256"}],"stateMutability":"view","type":"function"}]',
  'VotingSystem',
);

class VotingSystem extends _i1.GeneratedContract {
  VotingSystem({
    required _i1.EthereumAddress address,
    required _i1.Web3Client client,
    int? chainId,
  }) : super(
          _i1.DeployedContract(
            _contractAbi,
            address,
          ),
          client,
          chainId,
        );

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> closeProposal(
    ({BigInt proposalId}) args, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[1];
    assert(checkSignature(function, '0386a016'));
    final params = [args.proposalId];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> createProposal(
    ({String title, String description, BigInt durationInMinutes}) args, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[2];
    assert(checkSignature(function, '0ce0ebf4'));
    final params = [
      args.title,
      args.description,
      args.durationInMinutes,
    ];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<GetProposal> getProposal(
    ({BigInt proposalId}) args, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[3];
    assert(checkSignature(function, 'c7f758a8'));
    final params = [args.proposalId];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return GetProposal(response);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<BigInt> getProposalsCount({_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[4];
    assert(checkSignature(function, '98e527d3'));
    final params = [];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as BigInt);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<_i1.EthereumAddress> owner({_i1.BlockNum? atBlock}) async {
    final function = self.abi.functions[5];
    assert(checkSignature(function, '8da5cb5b'));
    final params = [];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return (response[0] as _i1.EthereumAddress);
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<Proposals> proposals(
    ({BigInt $param5}) args, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[6];
    assert(checkSignature(function, '013cf08b'));
    final params = [args.$param5];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return Proposals(response);
  }

  /// The optional [transaction] parameter can be used to override parameters
  /// like the gas price, nonce and max gas. The `data` and `to` fields will be
  /// set by the contract.
  Future<String> vote(
    ({BigInt proposalId}) args, {
    required _i1.Credentials credentials,
    _i1.Transaction? transaction,
  }) async {
    final function = self.abi.functions[7];
    assert(checkSignature(function, '0121b93f'));
    final params = [args.proposalId];
    return write(
      credentials,
      transaction,
      function,
      params,
    );
  }

  /// The optional [atBlock] parameter can be used to view historical data. When
  /// set, the function will be evaluated in the specified block. By default, the
  /// latest on-chain block will be used.
  Future<Votes> votes(
    ({_i1.EthereumAddress $param7, BigInt $param8}) args, {
    _i1.BlockNum? atBlock,
  }) async {
    final function = self.abi.functions[8];
    assert(checkSignature(function, '9f2524ee'));
    final params = [
      args.$param7,
      args.$param8,
    ];
    final response = await read(
      function,
      params,
      atBlock,
    );
    return Votes(response);
  }

  /// Returns a live stream of all ProposalCreated events emitted by this contract.
  Stream<ProposalCreated> proposalCreatedEvents({
    _i1.BlockNum? fromBlock,
    _i1.BlockNum? toBlock,
  }) {
    final event = self.event('ProposalCreated');
    final filter = _i1.FilterOptions.events(
      contract: self,
      event: event,
      fromBlock: fromBlock,
      toBlock: toBlock,
    );
    return client.events(filter).map((_i1.FilterEvent result) {
      final decoded = event.decodeResults(
        result.topics!,
        result.data!,
      );
      return ProposalCreated(
        decoded,
        result,
      );
    });
  }

  /// Returns a live stream of all Voted events emitted by this contract.
  Stream<Voted> votedEvents({
    _i1.BlockNum? fromBlock,
    _i1.BlockNum? toBlock,
  }) {
    final event = self.event('Voted');
    final filter = _i1.FilterOptions.events(
      contract: self,
      event: event,
      fromBlock: fromBlock,
      toBlock: toBlock,
    );
    return client.events(filter).map((_i1.FilterEvent result) {
      final decoded = event.decodeResults(
        result.topics!,
        result.data!,
      );
      return Voted(
        decoded,
        result,
      );
    });
  }
}

class GetProposal {
  GetProposal(List<dynamic> response)
      : title = (response[0] as String),
        description = (response[1] as String),
        voteCount = (response[2] as BigInt),
        endTime = (response[3] as BigInt),
        isActive = (response[4] as bool);

  final String title;

  final String description;

  final BigInt voteCount;

  final BigInt endTime;

  final bool isActive;
}

class Proposals {
  Proposals(List<dynamic> response)
      : title = (response[0] as String),
        description = (response[1] as String),
        voteCount = (response[2] as BigInt),
        endTime = (response[3] as BigInt),
        isActive = (response[4] as bool);

  final String title;

  final String description;

  final BigInt voteCount;

  final BigInt endTime;

  final bool isActive;
}

class Votes {
  Votes(List<dynamic> response)
      : hasVoted = (response[0] as bool),
        proposalId = (response[1] as BigInt);

  final bool hasVoted;

  final BigInt proposalId;
}

class ProposalCreated {
  ProposalCreated(
    List<dynamic> response,
    this.event,
  )   : proposalId = (response[0] as BigInt),
        title = (response[1] as String),
        endTime = (response[2] as BigInt);

  final BigInt proposalId;

  final String title;

  final BigInt endTime;

  final _i1.FilterEvent event;
}

class Voted {
  Voted(
    List<dynamic> response,
    this.event,
  )   : voter = (response[0] as _i1.EthereumAddress),
        proposalId = (response[1] as BigInt);

  final _i1.EthereumAddress voter;

  final BigInt proposalId;

  final _i1.FilterEvent event;
}
