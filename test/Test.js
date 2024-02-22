const {
  time,
  loadFixture,
} = require("@nomicfoundation/hardhat-toolbox/network-helpers");
const { anyValue } = require("@nomicfoundation/hardhat-chai-matchers/withArgs");
const { expect } = require("chai");
const { ethers } = require("hardhat");

async function deploy() {
  // Contracts are deployed using the first signer/account by default
  const [owner, user1, user2, user3, user4, user5] = await ethers.getSigners();

  const SAVINGS = await ethers.getContractFactory("SAVINGS");
  const savings = await SAVINGS.deploy();

  return { owner, user1, user2, user3, user4, savings };
}

describe("SAVINGS", function () {
  it("should pass", async function () {
    const { owner, user1, user2, user3, user4, savings } = await loadFixture(
      deploy
    );

    //const provider = waffle.provider;

    await savings.deposit({ value: ethers.parseEther("10") });
    //await savings.withdraw(ethers.parseEther("15"));
    /*  await savings.withdrawToAnotherAddress(
      ethers.parseEther("5"),
      user1.address
    ); */

    //console.log(await ethers.provider.getBalance(owner.address));
    //console.log(await ethers.provider.getBalance(user1.address));
    console.log(await savings.getUserBalance());

    function sleep(ms) {
      return new Promise((resolve) => setTimeout(resolve, ms));
    }
  });
});
