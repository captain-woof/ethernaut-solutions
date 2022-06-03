import * as dotenv from "dotenv";
import { HardhatUserConfig } from "hardhat/config";
import "@nomiclabs/hardhat-etherscan";
import "@nomiclabs/hardhat-waffle";
import "@typechain/hardhat";

dotenv.config({ path: "./.env" });

const config: HardhatUserConfig = {
  solidity: "0.6.0",
  networks: {
    rinkeby: {
      accounts: [process.env.PRIVATE_KEY as string],
      url: "https://rinkeby.infura.io/v3/9aa3d95b3bc440fa88ea12eaa4456161" // FROM `https://rpc.info/`
    }
  },
  etherscan: {
    apiKey: {
      rinkeby: process.env.ETHERSCAN_API_KEY
    }
  }
};

export default config;
