import { ethers } from "hardhat";

async function main() {
  const VotingSystem = await ethers.getContractFactory("VotingSystem");
  const votingSystem = await VotingSystem.deploy();

  console.log(`VotingSystem Contract deployed to: ${await votingSystem.getAddress()}`);
  
  // 获取部署者地址
  const [deployer] = await ethers.getSigners();
  console.log(`Deployer address: ${deployer.address}`);

  // 创建一个测试提案
  const tx = await votingSystem.createProposal(
    "测试提案",
    "这是一个用于测试的提案",
    BigInt(60) // 60分钟
  );
  await tx.wait();

  console.log("测试提案已创建");

  // 获取提案数量
  const proposalCount = await votingSystem.getProposalsCount();
  console.log(`当前提案数量: ${proposalCount}`);

  // 获取第一个提案详情
  const proposal = await votingSystem.getProposal(0);
  console.log("提案详情:", {
    title: proposal[0],
    description: proposal[1],
    voteCount: proposal[2],
    endTime: new Date(Number(proposal[3]) * 1000).toLocaleString(),
    isActive: proposal[4]
  });
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});