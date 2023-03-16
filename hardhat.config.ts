import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";

const fs = require("fs");
const privateKey = fs.readFileSync(".privateKey").toString().trim();

module.exports = {
  defaultNetwork: "hardhat",
  networks: {
    hardhat: {},
    aurora: {
      url: "https://testnet.aurora.dev",
      accounts: [privateKey],
    },
  },
  solidity: {
    version: "0.8.1",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200,
      },
    },
  },
};
