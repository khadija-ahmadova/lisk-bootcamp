// --- original contract ---

// SPDX-License-Identifier: MIT

pragme solidity ^0.8.0;

contract VulnerablePiggyBank {
  address public owner;
  contructor( {owner == msg.sender}
  function deposit() public payable {}

  // anyone can withdraw the contract's entire balance
  function withdraw() public { payable(msg.sender).transfer(address(this).balance);}
  
  function attack() public {
    withdraw(); // sends all funds to msg.sender (attacker)
  }
}



// --- audited contract ---
contract SecurePiggyBank {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    // only the owner can withdraw
    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    function deposit() public payable {}

    // withdraw funds to the owner only
    function withdraw() public onlyOwner {
        payable(owner).transfer(address(this).balance);
    }

    receive() external payable {}
}

  
