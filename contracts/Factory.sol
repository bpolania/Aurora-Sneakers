// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./SneakerNFT.sol";

contract SampleFactory {
    address[] public nfts;

    function createSneakerNFT() public returns (address) {
        SneakerNFT nft = new SneakerNFT();
        nfts.push(address(nft));
        return address(nft);
    }

    function getNFTContracts() public view returns (address[] memory) {
        return nfts;
    }
}