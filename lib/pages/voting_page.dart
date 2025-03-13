import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterzerodemo/pages/VotingSystemContractHelper.dart';
import 'package:flutterzerodemo/pages/envreplace.dart';
import 'package:web3dart/credentials.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart' as http;
import '../services/WalletService.dart';

class VotingPage extends StatefulWidget {
  @override
  _VotingPageState createState() => _VotingPageState();
}

class _VotingPageState extends State<VotingPage> {
  late VotingSystemContractHelper _votingHelper;
  late WalletService _walletService;
  late Credentials? _credentials;
  List<Map<String, dynamic>> _proposals = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeServices();
  }

  Future<void> _initializeServices() async {
    try {
      _walletService = WalletService();
      final privateKey = await _walletService.getPrivateKey();
      _credentials = await _walletService.getCredentials(privateKey!);

      _votingHelper = await VotingSystemContractHelper.create(
        rpcUrl: EnvReplace.localhost,
        wsUrl: EnvReplace.websocket,
        //这是npx hardhat run scripts/deployVoting.ts --network localhost 部署的地址
        contractAddress: EnvReplace.delployedContractAddress,
      );

      await _loadProposals();
    } catch (e) {
      print('初始化失败: $e');
    }
  }

  Future<void> _loadProposals() async {
    try {
      setState(() => _isLoading = true);
      final count = await _votingHelper.getProposalsCount();
      print('获取合约提案个数: $count');
      _proposals.clear();

      for (var i = BigInt.zero; i < count; i = i + BigInt.one) {
        final proposal = await _votingHelper.getProposal(i);
        _proposals.add({
          'id': i.toString(),
          'title': proposal.title,
          'description': proposal.description,
          'voteCount': proposal.voteCount,
          'endTime': DateTime.fromMillisecondsSinceEpoch(
            proposal.endTime.toInt() * 1000,
          ),
          'isActive': proposal.isActive,
        });
      }

      setState(() => _isLoading = false);
    } catch (e) {
      print('加载提案失败: $e');
      setState(() => _isLoading = false);
    }
  }

  Future<void> _createProposal() async {
    final result = await showDialog(
      context: context,
      builder: (context) => CreateProposalDialog(),
    );

    if (result != null && result is Map<String, dynamic>) {
      try {
        await _votingHelper.createProposal(
          credentials: _credentials!,
          title: result['title'],
          description: result['description'],
          durationInMinutes: BigInt.from(result['duration']),
        );
        await _loadProposals();
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('创建提案失败: $e')));
      }
    }
  }

  Future<void> _vote(String proposalId) async {
    try {
      await _votingHelper.vote(
        credentials: _credentials!,
        proposalId: BigInt.parse(proposalId),
      );
      await _loadProposals();
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('投票失败: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('区块链投票系统'),
        actions: [
          IconButton(icon: Icon(Icons.refresh), onPressed: _loadProposals),
        ],
      ),
      body:
          _isLoading
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                itemCount: _proposals.length,
                itemBuilder: (context, index) {
                  final proposal = _proposals[index];
                  final isActive = proposal['isActive'];
                  print(isActive);
                  final endTime = proposal['endTime'];
                  print(endTime);
                  final hasEnded = DateTime.now().isAfter(proposal['endTime']);
                  return Card(
                    margin: EdgeInsets.all(8.0),
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            proposal['title'],
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          SizedBox(height: 8.0),
                          Text(proposal['description']),
                          SizedBox(height: 8.0),
                          Text('当前票数: ${proposal['voteCount']}'),
                          Text(
                            '结束时间: ${proposal['endTime'].toString()}',
                            style: TextStyle(
                              color: hasEnded ? Colors.red : Colors.green,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          if (isActive && !hasEnded)
                            ElevatedButton(
                              //颜色根据isActive和hasEnded来改变
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    isActive & hasEnded
                                        ? Colors.red
                                        : Colors.green,
                              ),
                              onPressed: () => _vote(proposal['id']),
                              child: Text('投票'),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createProposal,
        child: Icon(Icons.add),
        tooltip: '创建新提案',
      ),
    );
  }
}

class CreateProposalDialog extends StatefulWidget {
  @override
  _CreateProposalDialogState createState() => _CreateProposalDialogState();
}

class _CreateProposalDialogState extends State<CreateProposalDialog> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _durationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('创建新提案'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(labelText: '标题'),
              validator: (value) => value?.isEmpty ?? true ? '请输入标题' : null,
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: '描述'),
              validator: (value) => value?.isEmpty ?? true ? '请输入描述' : null,
            ),
            TextFormField(
              controller: _durationController,
              decoration: InputDecoration(labelText: '持续时间（分钟）'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value?.isEmpty ?? true) return '请输入持续时间';
                if (int.tryParse(value!) == null) return '请输入有效的数字';
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('取消'),
        ),
        TextButton(
          onPressed: () {
            if (_formKey.currentState?.validate() ?? false) {
              Navigator.of(context).pop({
                'title': _titleController.text,
                'description': _descriptionController.text,
                'duration': int.parse(_durationController.text),
              });
            }
          },
          child: Text('创建'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _durationController.dispose();
    super.dispose();
  }
}
