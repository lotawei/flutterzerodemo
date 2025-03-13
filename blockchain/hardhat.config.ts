// blockchain/hardhat.config.ts
import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import * as dotenv from "dotenv";
require("dotenv").config();
dotenv.config();

const config: HardhatUserConfig = {
  solidity: "0.8.28",
  networks: {
    localhost:{
        url: "http://127.0.0.1:8545",
        accounts: [process.env.PRIVATE_KEY]
    }
//     sepolia: {
//        url: process.env.INFURA_URL, // Infura 提供的 Sepolia RPC
//        accounts: [process.env.PRIVATE_KEY] // 钱包私钥
//      }
//     sepolia: {
//       url: `https://sepolia.infura.io/v3/${process.env.INFURA_API_KEY}`,
//       accounts: [process.env.DEPLOYER_PRIVATE_KEY!],
//     },
  },
  etherscan: {
    apiKey: process.env.ETHERSCAN_API_KEY,
  }
};

task("accounts", "Prints the list of accounts", async (_, hre) => {
  const accounts = await hre.ethers.getSigners();
  for (const account of accounts) {
    console.log(account.address);
  }
});
//作用是使用  npx hardhat getProposalsCount --network localhost 测试可以用于
task("getProposalsCount", "获取提案数量")
  .setAction(async (taskArgs) => {
    const VotingSystem = await ethers.getContractFactory("VotingSystem");
    //这个值是 npx hardhat run scripts/deployVoting.ts --network localhost 部署的一个地址
    const votingSystem = await VotingSystem.attach("0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512"); // 将 <contract-address> 替换为你的合约地址

    const proposalCount = await votingSystem.getProposalsCount();
    
    console.log(`当前提案数量: ${proposalCount}`);
  });

task("getProposal", "获取提案详情")
  .addParam("id", "提案 ID")
  .setAction(async (taskArgs) => {
    const VotingSystem = await ethers.getContractFactory("VotingSystem");
    const votingSystem = await VotingSystem.attach("0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512"); // 将 <contract-address> 替换为你的合约地址

    const proposal = await votingSystem.getProposal(taskArgs.id);
    console.log("提案详情:", {
        title: proposal[0],
        description: proposal[1],
        voteCount: proposal[2],
        endTime: new Date(Number(proposal[3]) * 1000).toLocaleString(),
        isActive: proposal[4]
    });
  });


export default config;
