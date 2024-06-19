const { ethers, JsonRpcProvider } = require('ethers');

const INFURA_ID = '5fb26bc82c484597a18dd9aba73bd52b';
const provider = new JsonRpcProvider(
  `https://sepolia.infura.io/v3/${INFURA_ID}`,
);

const account1 = '0xD47B767Ab64eF004FBE85d55a49f9f2C9f305Cce'; // Sender
const account2 = '0x53eFB28860Dc0C7Ba1E03b99ebfbbe975b82c622'; // Receiver

const privateKey1 =
  '47b16c7ca1ffe6b86a662c5005bf54838f0bc0b5ef1e808c43c80766824c0776'; // Private key of account 1
const wallet = new ethers.Wallet(privateKey1, provider); //just like how we select provider/network and select our account/private key

const main = async () => {
  const senderBalanceBefore = await provider.getBalance(account1);
  const recieverBalanceBefore = await provider.getBalance(account2);

  //Show balance before transfer
  console.log(
    `\nSender balance before: ${ethers.formatEther(senderBalanceBefore)}`,
  );
  console.log(
    `reciever balance before: ${ethers.formatEther(recieverBalanceBefore)}\n`,
  );

  //we do not need to specify 'account1' here as we have created 'wallet' from account1's private key
  const tx = await wallet.sendTransaction({
    to: account2,
    value: ethers.parseEther('0.025'),
  });

  //Wait for transaction to be mined in the blockchain
  await tx.wait();
  console.log(tx);

  const senderBalanceAfter = await provider.getBalance(account1);
  const recieverBalanceAfter = await provider.getBalance(account2);

  //Show balance after transfer
  console.log(
    `\nSender balance after: ${ethers.formatEther(senderBalanceAfter)}`,
  );
  console.log(
    `reciever balance after: ${ethers.formatEther(recieverBalanceAfter)}\n`,
  );
};

main();
