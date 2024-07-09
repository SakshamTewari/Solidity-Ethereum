/*

Hash Function
-------------

Hash functions are used to take input data of any size and output a unique series of bits of a specific size representing that original data.
An ideal cryptographic hash function can, given any input, return a consistent yet seemingly random output.
It's important that the output is consistent so we can depend on putting the same inputs in and receiving the same output.
It's also important for the randomness to be strong enough where it's impossible to re-construct the input from the output. This way, we know it's tamper-proof.

For example the SHA256 algorithm will take an input like Dan and return a consistent output:

    const hash = SHA256("Dan");
    console.log( hash.toString() ); // b12595…1cbe7e

    The log is shortened, it is actually 64 hexadecimal characters long. SHA256 outputs 256 bits. 
    Since a hexadecimal character requires 4 bits, there are 64 hexadecimal characters in a SHA256 hash.


Crypto-JS
---------

The crypto-js library provides us with several cryptographic utilities. 
Specifically the SHA256 method is an implementation of the SHA256 algorithm designed by the NSA.

This function will take any string as an argument, regardless of size, and hash it to a 256 bit array. 
If we call toString() on that returned object we'll receive a 64 character hexadecimal string.


Hexadecimal
-----------

You'll notice that the outputs shown consist of a set of characters ranging from a to f and 0 to 9. 
These are hexadecimal characters. 
It has become commonplace to use hexadecimal when displaying a hash.

You'll also often see a hash with a 0x in front of it. This prefix means that hexadecimal notation is being used. 
So if you see a string of characters "0x123abc", the "0x" is denoting the use of hexadecimals and the string's value is actually just "123abc".


 regular expression (regex)
 -------------------------- 

    /^[0-9A-F]{64}$/i. 
    It's simply testing to see that this is a hexadecimal output of 64 characters.


Why 64 Hexadecimal Characters?
------------------------------

A bit can represent two values: 0 and 1. Two bits can represent four values 00, 01, 10 and 11. 
Four bits can represent 16 values 0000 through 1111. 
We can map each of these values to a character in the hexadecimal alphabet since it contains 16 characters! 
Since SHA256 outputs 256 bits, we divide that by the number of bits to represent a hexadecimal character (4) to get 64 characters.

*/

const SHA256 = require('crypto-js/sha256');

class Block {
  toHash() {
    return SHA256('Saksham'); // a hash!
  }
}

module.exports = Block;

/*
When creating a new block, data will be passed to its constructor:

const block = new Block("Alice sent Bob 1 BTC");
console.log( block.data ); // Alice sent Bob 1 BTC
 
As shown above, let's add a data property to the Block.

Add a constructor to our Block class that takes one argument data and assigns it to this.data
Once you have added data to the block, use this data to calculate the block's hash in the toHash function!
*/

const SHA256 = require('crypto-js/sha256');

class Block {
  constructor(data) {
    this.data = data;
  }
  toHash() {
    return SHA256(this.data); // a hash!
  }
}

module.exports = Block;

/*

Genesis Block
-------------

The genesis block is the first block in the chain, where it all kicks off!
Every block after the genesis block links back to the first one, but the genesis block has no previous block!

The Blockchain.js file contains the Blockchain class with a chain array. Let's add the Genesis Block to this array.

Create a new Block in the Blockchain constructor then add it to the chain array.
*/

const Block = require('./Block');

class Blockchain {
  constructor() {
    const block = new Block();
    this.chain = [block];
    [
      /* TODO: Create the genesis block here */
    ];
  }
}

module.exports = Blockchain;

/*

addBlock function on our Blockchain class.
-----------------

This function should take in a new block and add it to the chain array:


const blockchain = new Blockchain();
const block = new Block("Charlie sent Dave 2 BTC");

blockchain.addBlock(block);

console.log(blockchain.chain.length); // 2
*/

const Block = require('./Block');

class Blockchain {
  constructor() {
    const block = new Block();
    this.chain = [block];
    [
      /* TODO: Create the genesis block here */
    ];
  }

  addBlock(block) {
    return this.chain.push(block);
  }
}

module.exports = Blockchain;

/*
Linking The Blocks
------------------

Add a previousHash property to each block. The value of this property should be the hash of the block before it in the chain.
Use this previousHash property in the calculation of the block's hash.

A good spot to add the previousHash property on the block would be in the addBlock function, where a block is placed on the chain.
So far, the Block class in your Block.js file does not yet contain a previousHash property and currently only hashes this.data of a block - you must also include the block's this.previousHash property in the toHash function!
You can add multiple inputs to the SHA256 function by using the + operator, for example:
const hash = SHA256("dog" + "cat"); // hash of dog and cat together

*/

const SHA256 = require('crypto-js/sha256');

class Block {
  constructor(data) {
    this.data = data;
  }
  toHash() {
    return SHA256(this.data + this.previousHash); // a hash!
  }
}

module.exports = Block;

const Block = require('./Block');

class Blockchain {
  constructor() {
    this.chain = [new Block()];
    [
      /* TODO: Create the genesis block here */
    ];
  }

  addBlock(block) {
    block.previousHash = this.chain[this.chain.length - 1].toHash();
    return this.chain.push(block);
  }
}

module.exports = Blockchain;

/*

Chain Validation
----------------

Blockchains are run by a network of computers. When a computer finds a new block, it broadcasts its new version of the blockchain to all of its peers. There may be multiple versions of the blockchain at any given time. 
However, the longest valid blockchain is the accepted one.


Create a function called isValid on our Blockchain that will return true or false if a block is valid or invalid respectively
isValid should check the integrity of every block in its chain by looking at each block's previousHash field and making sure that it is equal to the hash of the block before it

To compare the output of the SHA256 function you will need to convert it into a string (.toString) before comparing. Example:

const hash1 = SHA256("a");
const hash2 = SHA256("a");

console.log(hash1 === hash2); // false
console.log(hash1.toString() === hash2.toString()); // true

Notice that first one is false! 
These two are objects and are compared by reference which is why we need to convert it to a string!
*/

const Block = require('./Block');

class Blockchain {
  constructor() {
    this.chain = [new Block()];
    [
      /* TODO: Create the genesis block here */
    ];
  }

  addBlock(block) {
    block.previousHash = this.chain[this.chain.length - 1].toHash();
    return this.chain.push(block);
  }

  isValid() {
    for (let i = this.chain.length - 1; i > 0; i--) {
      let block = this.chain[i],
        prev = this.chain[i - 1];
      if (block.previousHash.toString() !== prev.toHash().toString())
        return false;
    }
    return true;
  }
}

module.exports = Blockchain;
