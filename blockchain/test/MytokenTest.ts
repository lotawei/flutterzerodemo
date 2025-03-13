const {
loadFixture,
} = require("@nomicfoundation/hardhat-toolbox/network-helpers");
const { expect } = require("chai");

describe("Mytoken", function () {
      async function deployTokenFixture() {
          const [owner] = await ethers.getSigners();
          const hardhatToken = await ethers.deployContract("MyToken");
          // Fixtures can return anything you consider useful for your tests
          return { hardhatToken, owner };
        }
        it("测试合约拥有者的总代币", async function () {
                  const { hardhatToken , owner} = await loadFixture(deployTokenFixture);
                   const ownerBalance = await hardhatToken.balanceOf(owner.address);
                   console.log("ownerBalance:", ownerBalance.toString());
                   expect(await hardhatToken.totalSupply()).to.equal(ownerBalance);
        });

})