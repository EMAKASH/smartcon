
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Escrow {
    address public buyer;
    address public seller;
    uint public amount;
    bool public deposited;

    constructor(address _seller) {
        buyer = msg.sender;
        seller = _seller;
        amount = 0;
        deposited = false;
    }

    function deposit() external payable {
        require(msg.sender == buyer, "Only buyer can deposit");
        require(!deposited, "Already deposited");

        amount = msg.value;
        deposited = true;
    }

    function releaseFunds() external {
        require(msg.sender == buyer, "Only buyer can release funds");
        require(deposited, "No funds deposited");

        payable(seller).transfer(amount);
        deposited = false;
    }
}
