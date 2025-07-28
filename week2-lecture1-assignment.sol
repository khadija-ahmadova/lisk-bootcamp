// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/math/SafeMath.sol";

// Base Contract: VaultBase
contract VaultBase {
    using SafeMath for uint256;

    mapping(address => uint256) internal balances;

    event Deposited(address indexed user, uint256 amount);
    event Withdrawn(address indexed user, uint256 amount);
}


// Derived Contract: VaultManager
contract VaultManager is VaultBase {

    // Deposit Ether
    function deposit() external payable {
        require(msg.value > 0, "Cannot deposit 0 ETH");
        balances[msg.sender] = balances[msg.sender].add(msg.value);
        emit Deposited(msg.sender, msg.value);
    }

    // Withdraw Ether
    function withdraw(uint256 amount) external {
        require(amount > 0, "Amount must be greater than 0");
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] = balances[msg.sender].sub(amount);
        payable(msg.sender).transfer(amount);
        emit Withdrawn(msg.sender, amount);
    }

    // View your vault balance
    function getBalance() external view returns (uint256) {
        return balances[msg.sender];
    }
}
