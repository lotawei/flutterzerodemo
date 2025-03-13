// blockchain/scripts/deploy.ts
import { ethers } from "hardhat";

async function main() {
  const Token = await ethers.getContractFactory("MyToken");
  const token = await Token.deploy();

  console.log(`Contract deployed to: ${await token.getAddress()}`);
//   const owner = await ethers.getSigner(0); error
  console.log(`Token name: ${await token.name()}`);
  console.log(`Token symbol: ${await token.symbol()}`);
  console.log(`Token total supply: ${await token.totalSupply()}`);
  console.log(`Token decimals: ${await token.decimals()}`);

    // 获取账户
  const signer = await ethers.provider.getSigner();
   console.log(`Owner address: ${typeof signer}`);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
