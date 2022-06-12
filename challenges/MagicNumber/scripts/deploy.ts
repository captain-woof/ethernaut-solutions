import { ethers } from "hardhat";

async function main() {
  /**
     * 602A PUSH1 VALUE
     * 6000 PUSH1 MEM_LOCATION
     * 52 MSTORE (MEM_LOCATION, VALUE)
     * 
     * 6020 PUSH1 LENGTH_OF_VALUE
     * 6000 PUSH1 MEM_LOCATION
     * F3 RETURN (MEM_LOCATION, LENGTH_OF_VALUE)
     */
  const runtimeBytecode = `602A60005260206000F3`; // 10 bytes

  /**
   * 600A PUSH1 LENGTH_OF_RUNTIME_CODE
   * 600C PUSH1 SOURCE_MEM_LOCATION_OFFSET
   * 6000 PUSH1 DESTINATION_MEM_LOCATION 
   * 39 CODECOPY (DESTINATION_MEM_LOCATION, SOURCE_MEM_LOCATION_OFFSET, LENGTH_OF_RUNTIME_CODE)
   * 
   * 600A PUSH1 LENGTH_OF_RUNTIME_CODE
   * 6000 PUSH1 DESTINATION_MEM_LOCATION
   * F3 RETURN (DESTINATION_MEM_LOCATION, LENGTH_OF_RUNTIME_CODE)
   */
  const initializationBytecode = `600A600C600039600A6000F3`; // 12 bytes

  // Deploy contract
  const bytecodeToDeploy = `0x${initializationBytecode}${runtimeBytecode}`;
  const deployer = (await ethers.getSigners())[0];
  const deployTx = await deployer.sendTransaction({
    data: bytecodeToDeploy,
    
  });
  const { contractAddress } = await deployTx.wait();

  // Print contract address
  console.log(`[+] Solver deployed: ${contractAddress}`);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
