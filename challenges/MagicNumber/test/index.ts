import { assert, expect } from "chai";
import { ethers } from "hardhat";
import { BigNumber } from "ethers";

describe("Magic Number", function () {

  let contractAddr: string;

  before(async () => {
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
      data: bytecodeToDeploy
    });
    const deployRcpt = await deployTx.wait();
    contractAddr = deployRcpt.contractAddress;
  });

  it("Deployed contract should return 42", async function () {
    const signer = (await ethers.getSigners())[0];
    const result = await signer.call({
      to: contractAddr,
      data: "0x650500c1" // Selector for "whatIsTheMeaningOfLife()"
    });

    const resultDecoded = ethers.utils.defaultAbiCoder.decode(["uint256"], result)[0] as BigNumber;
    assert.isTrue(resultDecoded.eq(42), "Wrong value returned!");
  });
});
