const { ethers } = require('ethers');

const INFURA_ID = '5fb26bc82c484597a18dd9aba73bd52b';
const provider = new ethers.providers.JsonRpcProvider(
  `https://sepolia.infura.io/v3/${INFURA_ID}`,
);

const account1 = '0xD47B767Ab64eF004FBE85d55a49f9f2C9f305Cce'; // Sender
const account2 = '0x53eFB28860Dc0C7Ba1E03b99ebfbbe975b82c622'; // Receiver

const privateKey1 =
  '47b16c7ca1ffe6b86a662c5005bf54838f0bc0b5ef1e808c43c80766824c0776'; // Private key of account 1
con;
const ERC20_ABI = [
  'function balanceOf(address) view returns (uint)',
  'function transfer(address to, uint amount) returns (bool)',
];

const address = '';
const contract = new ethers.Contract(address, ERC20_ABI, provider);

const main = async () => {
  const balance = await contract.balanceOf(account1);

  console.log(`\nReading from ${address}\n`);
  console.log(`Balance of sender: ${balance}\n`);

  const contractWithWallet = contract.connect(wallet);

  const tx = await contractWithWallet.transfer(account2, balance);
  await tx.wait();

  console.log(tx);

  const balanceOfSender = await contract.balanceOf(account1);
  const balanceOfReciever = await contract.balanceOf(account2);

  console.log(`\nBalance of sender: ${balanceOfSender}`);
  console.log(`Balance of reciever: ${balanceOfReciever}\n`);
};

main();
