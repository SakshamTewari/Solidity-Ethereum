const { ethers } = require('ethers');
const INFURA_ID = '5fb26bc82c484597a18dd9aba73bd52b';

//connection with blockchain (node)
const provider = new ethers.providers.JsonRpcProvider(
  `https://mainnet.infura.io/v3/${INFURA_ID}`,
);

//lets check for balance of any random address on ethereum
//for that, we need an async function to have await as .getBalance returns a promise

const main = async () => {
  const address = '0x4675C7e5BaAFBFFbca748158bEcBA61ef3b0a263'; //random address
  const balance = await provider.getBalance(address);
  console.log(
    `\nETH Balance of ${address} --> ${ethers.utils.formatEther(balance)}\n`,
  );
};

main();
