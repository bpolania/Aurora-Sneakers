// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/AccessControl.sol";

contract Treasury is AccessControl {
    
    address[] public artists;
    mapping(address => uint256) private accruedRoyalties;
    mapping(address => uint256) private royalties;

    bytes32 public constant ADMIN_ROLE = keccak256("ADMIN_ROLE");

    constructor(address admin) {
        _grantRole(ADMIN_ROLE, admin);
    }

    modifier onlyAdmin() {
        require(hasRole(ADMIN_ROLE, msg.sender), "Caller is not a minter");
        _;
    }

    function reportSale(address nftContract) public onlyAdmin {
        accruedRoyalties[nftContract]++;
    }

    function payRoyalties() public onlyAdmin {
        for (uint256 i = 0; i < artists.length; i++) {
            address artist = artists[i];
            uint256 amountToBePaid = calculateRoyalties(artist);
            payRoyalties(amountToBePaid, artist);
            accruedRoyalties[artist] = 0;
        }
    }

    function fundContract() public onlyAdmin payable {}

    function calculateRoyalties(address nftContract) public view returns (uint256) {
        uint256 amount = royalties[nftContract];
        uint256 totalSales = accruedRoyalties[nftContract];
        uint256 royaltiesToBePaid = amount * totalSales;
        return royaltiesToBePaid;
    }

    function payRoyalties(uint256 amount, address to) private onlyAdmin {
        require(amount <= address(this).balance, "Not enough funds in contract to pay royalties");
        payable(to).transfer(amount);
    }
}
