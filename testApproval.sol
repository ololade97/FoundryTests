// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";


interface StandardToken {
    function balanceOf(address _owner) external;
    function transfer(address _to, uint256 _value) external;
    function transferFrom(address _from, address _to, uint256 _value) external;
    function approve(address _spender, uint256 _value) external;
    function allowance(address _owner, address _spender) external;

}

contract StandardTokenTest is Test {
    StandardToken public standardtoken;
    address approval = 0x1f4127Af75F454A28ac218DfD6aF0BCF087D1Fc1;
    address spender = 0xDef1C0ded9bec7F1a1670819833240f027b25EfF;
    address bob = vm.addr(1);

    function setUp() public {
        standardtoken = StandardToken(0x5e3346444010135322268a4630d2ED5F8D09446c);
        /*
        standardtoken.mint(4000);
        standardtoken.transfer(approval, 1500);
        */
    }

    function testApprove() public {
        console2.log("Before approval, balance of spender:", bob.balance);
        vm.prank(approval); //Address of an actual sender
        standardtoken.approve(bob, 5);
        vm.prank(spender);
        standardtoken.transferFrom(approval, bob, 5);
        console2.log("After approval, balance of spender:", bob.balance);
            }
    

}
/*

abstract contract Token {
    uint256 public totalSupply;

    function balanceOf(address _owner) view public virtual returns (uint256 balance);
    function transfer(address _to, uint256 _value) public virtual returns (bool success);
    function transferFrom(address _from, address _to, uint256 _value) public virtual returns (bool success);
    function approve(address _spender, uint256 _value) public virtual returns (bool success);
    function allowance(address _owner, address _spender) public virtual view returns (uint256 remaining);

    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
}

ERC 20 token 
contract StandardToken is Token {
    function transfer(address _to, uint256 _value) public override returns (bool success) {
        if (balances[msg.sender] >= _value && _value > 0) {
            balances[msg.sender] -= _value;
            balances[_to] += _value;
           emit Transfer(msg.sender, _to, _value);
            return true;
        } else {
            return false;
        }
    }

    function transferFrom(address _from, address _to, uint256 _value) public override returns (bool success) {
        if (balances[_from] >= _value && allowed[_from][msg.sender] >= _value && _value > 0) {
            balances[_to] += _value;
            balances[_from] -= _value;
            allowed[_from][msg.sender] -= _value;
            emit Transfer(_from, _to, _value);
            return true;
        } else {
            return false;
        }
    }

    function balanceOf(address _owner) view public override returns (uint256 balance) {
        return balances[_owner];
    }

    function approve(address _spender, uint256 _value) public override returns (bool success) {
        allowed[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    function allowance(address _owner, address _spender) view public override returns (uint256 remaining) {
        return allowed[_owner][_spender];
    }

       function mint(uint amount) external {
        balances[msg.sender] += amount;
        totalSupply += amount;
        emit Transfer(address(0), msg.sender, amount);
    }

    mapping(address => uint256) balances;
    mapping(address => mapping(address => uint256)) allowed;
    
}
*/
