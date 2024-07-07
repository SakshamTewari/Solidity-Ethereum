/*
The Mempool
-----------

Users who want to make transactions will broadcast their transactions to the blockchain network. 
The mempool is a place for miners to keep those transactions before adding them to a block.

Typically, the miner will take all the transactions with the highest transaction fees from the mempool. 
Then they'll add them to the block and attempt to find the proof of work.


Mining Blocks
-------------
In Bitcoin, blocks contain quite a bit of information in their header:
    the software version, a timestamp, the merkle root of its transactions, the previous block hash, and the difficulty.


(1) Implement the addTransaction function, which adds transactions to the mempool.
    Take the transaction sent to the function and push it on top of the mempool array.

(2) Update the mine() fuction to create a new block with a unique identifier and add it to our blocks array.
    Our block will be an object with a single property: an id that is equal to the block height prior to it being mined.
*/

const SHA256 = require('crypto-js/sha256');
const TARGET_DIFFICULTY =
  BigInt(0x0fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff);
const MAX_TRANSACTIONS = 10;

const mempool = [];
const blocks = [];

function addTransaction(transaction) {
  // TODO: add transaction to mempool
  mempool.push(transaction);
}

function mine() {
  // TODO: mine a block
  const block = {
    id: blocks.length,
  };
  const hash = SHA256(JSON.stringify(block));
  blocks.push({ ...block, hash });
}

module.exports = {
  TARGET_DIFFICULTY,
  MAX_TRANSACTIONS,
  addTransaction,
  mine,
  blocks,
  mempool,
};
