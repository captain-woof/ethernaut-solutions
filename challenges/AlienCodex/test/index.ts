import { assert, expect } from "chai";
import { ethers } from "hardhat";
import { AlienCodex, HackAlienCodex } from "../typechain";

describe("HackAlienCodex", function () {

  let hackAlienCodexContract: HackAlienCodex;
  let alienCodexContract: AlienCodex;

  before(async () => {

    const alienCodexContractFactory = await ethers.getContractFactory("AlienCodex");
    alienCodexContract = await alienCodexContractFactory.deploy();
    await alienCodexContract.deployed();

    const hackAlienCodexContractFactory = await ethers.getContractFactory("HackAlienCodex");
    hackAlienCodexContract = await hackAlienCodexContractFactory.deploy();
    await hackAlienCodexContract.deployed();
  });

  it("Caller should become new owner of Alien Codex", async function () {
    const caller = (await ethers.getSigners())[3];
    await (await hackAlienCodexContract.connect(caller).hack(alienCodexContract.address)).wait();
    assert.equal(await alienCodexContract.owner(), caller.address, "Hack did not succeed!");
  });
});
