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
