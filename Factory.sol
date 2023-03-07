// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract Factory {
    address[] public nftContracts;

    function createNFTContract(string memory _name, string memory _symbol) public returns (address) {
        ERC721 nftContract = new ERC721(_name, _symbol);
        nftContracts.push(address(nftContract));
        return address(nftContract);
    }

    function getNFTContracts() public view returns (address[] memory) {
        return nftContracts;
    }
}