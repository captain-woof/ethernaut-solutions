import { ethers } from "hardhat";

async function main() {
  const hackAlienCodexContractFactory = await ethers.getContractFactory("HackAlientCodex");
  const hackAlienCodexContract = await hackAlienCodexContractFactory.deploy();
  await hackAlienCodexContract.deployed();

  console.log("[+] HackAlienCodex deployed to:", hackAlienCodexContract.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
