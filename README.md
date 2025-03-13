# 区块链投票系统 Demo

这是一个基于Flutter和以太坊区块链的去中心化投票系统演示项目。该系统允许管理员创建投票提案，用户可以参与投票，所有投票记录都将被永久保存在区块链上。

## 功能特点

- 创建投票提案（仅管理员）
- 参与投票（所有用户）
- 查看投票结果
- 关闭投票（仅管理员）
- 基于区块链的透明投票记录

## 环境要求

- Flutter SDK (3.0.0 或更高版本)
- Node.js (14.0.0 或更高版本)
- npm 或 yarn
- MetaMask 钱包

## 安装步骤

### 1. 安装依赖

```bash
# 安装Flutter依赖
flutter pub get

# 安装区块链开发依赖
cd blockchain
npm install
```

### 2. 配置环境

1. 确保MetaMask已安装并连接到适当的测试网络（如Sepolia）
2. 在项目根目录创建`.env`文件，配置以下环境变量：
   ```
   INFURA_API_KEY=你的Infura API密钥
   PRIVATE_KEY=你的钱包私钥
   CONTRACT_ADDRESS=部署后的合约地址
   ```

### 3. 部署智能合约

```bash
cd blockchain

# 编译合约
npx hardhat compile

# 部署合约到测试网络
npx hardhat run scripts/deployVoting.ts --network sepolia
```

部署完成后，将得到的合约地址更新到`.env`文件中。

## 运行应用

```bash
# 启动Flutter应用
flutter run
```

## 使用说明

1. 启动应用后，使用MetaMask钱包连接
2. 管理员（合约部署者）可以：
   - 创建新的投票提案
   - 设置投票截止时间
   - 关闭投票
3. 普通用户可以：
   - 查看所有投票提案
   - 参与投票（每个提案只能投票一次）
   - 查看投票结果

## 常见问题

1. **Q: 连接钱包失败怎么办？**
   A: 确保MetaMask已安装并登录，且连接到正确的网络。

2. **Q: 交易失败怎么办？**
   A: 检查钱包中是否有足够的测试币，可以从测试网络水龙头获取。

3. **Q: 如何获取测试网络代币？**
   A: 访问Sepolia水龙头网站获取测试代币。

## 技术栈

- Flutter
- Solidity
- Hardhat
- Web3Dart
- MetaMask

## 贡献指南

欢迎提交Issue和Pull Request来改进这个项目。

## 许可证

MIT License
