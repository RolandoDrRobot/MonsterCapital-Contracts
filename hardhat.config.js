require('@nomiclabs/hardhat-waffle');
require('dotenv').config();

const privateKey = process.env.DEPLOYER_SIGNER_PRIVATE_KEY;
const projectID = process.env.INFURA_PROJECT_ID;

module.exports = {
  defaultNetwork: 'mumbai',
  networks: {
    hardhat: {
    },
    matic: {
      url: `https://polygon-mainnet.g.alchemy.com/v2/${projectID}`,
      accounts: [privateKey],
    },
    mumbai: {
      url: `https://polygon-mumbai.g.alchemy.com/v2/${projectID}`,
      accounts: [privateKey],
    }
  },
  solidity: {
    version: "0.8.0",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200
      }
    }
  },
  paths: {
    sources: "./contracts",
    tests: "./test",
    cache: "./cache",
    artifacts: "./artifacts"
  },
  mocha: {
    timeout: 20000
  }
};
