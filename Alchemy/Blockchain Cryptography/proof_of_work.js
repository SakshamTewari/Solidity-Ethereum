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


Block Hash
----------

Typically, all the information in the header of the block is hashed together to create a unique hash based on those properties.
If anything changes in the header, it will affect the hash. Since each block also contains the hash of the block before it, it will affect every future block as well.


Mine TX - Block Size 
--------------------

In Bitcoin, there is a specific block size limit that cannot be exceeded. 
The number of transactions that will fit inside of a block varies due to transactions being of all different sizes.



==================================================================================================================================================


(1) Implement the addTransaction function, which adds transactions to the mempool.
    Take the transaction sent to the function and push it on top of the mempool array.

(2) Update the mine() fuction to create a new block with a unique identifier and add it to our blocks array.
    Our block will be an object with a single property: an id that is equal to the block height prior to it being mined.

(3) Stringify the block object using JSON.stringify
    Take the SHA256 hash of the stringified block object
    Set the resulting value to a hash property on the mined block just before mining it

(4) Inside the mine function, pull transactions off the mempool and include them in the block in an array called transactions
    Remove each transaction you include in the block from the mempool
    Add the transactions array to the block before hashing the block
*/

// ==================================================================================================================================================

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
  let transactions = [];
  while (transactions.length < MAX_TRANSACTIONS && mempool.length > 0) {
    transactions.push(mempool.pop());
  }
  const block = {
    id: blocks.length,
    transactions,
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
