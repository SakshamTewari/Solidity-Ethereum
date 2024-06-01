//SPDX-License-Identifier: Unilicense
pragma solidity ^0.8.0;

/*
- Seller lists property
- Buyer deposits earnset
- Appraisal
- Inspection
- Lender approves 
- Lender funds
- Transfer Ownership
- Seller gets paid
*/

interface IERC721 {
    function transferFrom(address _from, address _to, uint _id) external;
}

contract Escrow {
    // lets store some addresses
    address public nftAddress;  // store smart contract address for the nft for real estate transaction
    address public lender;
    address public inspector;
    address payable public seller;

    //set all these values
    constructor(address _nftAddress, address payable _seller, address _inspector, address _lender){
        nftAddress = _nftAddress;
        lender = _lender;
        seller = _seller;
        inspector = _inspector;
    }
}