import { assert } from "chai";
import { ethers } from "hardhat";
import { HackedEvent } from "../typechain/HackGatekeeperOne";

describe("Bruteforcing", function () {
  it("GatekeeperOne should be hacked", async function () {

    // Deploy contracts
    const gatekeeperContract = await (await ethers.getContractFactory("GatekeeperOne")).deploy();
    const hackGatekeeperContract = await (await ethers.getContractFactory("HackGatekeeperOne")).deploy();
    await Promise.all([gatekeeperContract, hackGatekeeperContract].map((contract) => contract.deployed()));

    // Start bruteforcing
    const [lowerGasBrute, upperGasBrute] = [1, 1000];
    const hackTxn = await hackGatekeeperContract.hack(
      gatekeeperContract.address,
      lowerGasBrute,
      upperGasBrute
    );
    const { events } = await hackTxn.wait();
    const { args: { gasBrute } } = events?.find(({ event }) => (event === "Hacked")) as HackedEvent;

    // Tests
    assert.notEqual(gasBrute.toNumber(), 0, "Gas brute is zero!");
    console.log(`[>] GAS BRUTE: ${gasBrute}`);

    assert.equal(
      await (await ethers.getSigners())[0].getAddress(),
      await gatekeeperContract.entrant(),
      "Hack was unsuccessful!"
    )
  });
});
