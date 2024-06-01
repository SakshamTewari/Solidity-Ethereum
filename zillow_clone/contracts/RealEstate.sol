//SPDX-License-Identifier: Unilicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/utils/ERC721URIStorage.sol";

contract RealEstate is ERC721URIStorage{
     uint private _tokenIdCounter;

     constructor() ERC721("Real Estate", "REAL"){
        _tokenIdCounter = 0;
     }

     function mint(string memory tokenURI) public returns (uint) {
        _tokenIdCounter ++;
        uint newItemId = _tokenIdCounter;
        _mint(msg.sender, newItemId);
        _setTokenURI(newItemId, tokenURI);
        return newItemId;
     }

     function totalSupply() public view returns (uint) {
        return _tokenIdCounter;
     }
}