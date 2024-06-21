const { ethers, JsonRpcProvider } = require('ethers');

const INFURA_ID = '5fb26bc82c484597a18dd9aba73bd52b';
const provider = new JsonRpcProvider(
  `https://mainnet.infura.io/v3/${INFURA_ID}`,
);
const main = async () => {
  const block = await provider.getBlockNumber();

  console.log(`\nBlock Number: ${block}\n`);

  const blockInfo = await provider.getBlock(block);

  console.log(blockInfo); // gives all info of a particular block

  const transactions = await block.prefetchedTransactions;

  console.log(`\nLogging first transaction in block:\n`);
  console.log(transactions);
};

main();
