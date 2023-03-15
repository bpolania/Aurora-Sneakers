// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/AccessControl.sol";
import "./SneakerNFT.sol";

contract SneakerFactory is AccessControl {
    address[] public nfts;

    // Define the Admin role identifier
    bytes32 public constant ADMIN_ROLE = keccak256("ADMIN_ROLE");

    // Event emitted when a new SneakerNFT contract is created
    event SneakerNFTCreated(address indexed nftAddress, address indexed creator);

    constructor(address admin) {
        _grantRole(ADMIN_ROLE, admin);
    }

    modifier onlyAdmin() {
        require(hasRole(ADMIN_ROLE, msg.sender), "Caller is not a minter");
        _;
    }

    function createSneakerNFT() public onlyAdmin returns (address) {
        SneakerNFT nft = new SneakerNFT();
        nfts.push(address(nft));
        emit SneakerNFTCreated(address(nft), msg.sender);
        return address(nft);
    }

    function getNFTContracts() public view returns (address[] memory) {
        return nfts;
    }
}