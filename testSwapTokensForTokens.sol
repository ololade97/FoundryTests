// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "src/external/interfaces/ILBRouter.sol";

contract LBRouterTest is Test {
    LBRouter lbrouter;
    address bob = 0xd9b76dcc97894b0b24E7dFEbF363ed99d8eD7969;

    function setUp() public {
        lbrouter = LBRouter(0xb4315e873dBcf96Ffd0acd8EA43f689D8c20fB30);
    }


    function testSwapExactTokensForTokens() external {
        // Define and initialize the values for the Path struct
        uint256[] memory pairBinSteps = new uint256[](1);
        pairBinSteps[0] = 1;

        uint8[] memory versions = new uint8[](1);
        versions[0] = 2;

        address[] memory tokenPath = new address[](2);
        tokenPath[0] = address(0xB97EF9Ef8734C71904D8002F8b6Bc66Dd9c48a6E);
        tokenPath[1] = address(0x9702230A8Ea53601f5cD2dc00fDBc13d4dF4A8c7);

        // Create an instance of the Path struct and initialize its fields
        LBRouter.Path memory path;
        path.pairBinSteps = pairBinSteps;
        path.versions = versions;
        path.tokenPath = tokenPath;

uint256 amountIn = 100;
uint256 amountOutMin = 200;
uint256 amountOut;

        vm.startPrank(0xd9b76dcc97894b0b24E7dFEbF363ed99d8eD7969);

        vm.expectRevert("InsufficientAmountOut(amountOutMin, amountOut"));
        // Now, you can call the swapExactTokensForTokens function with the initialized path
        lbrouter.swapExactTokensForTokens(amountIn, amountOutMin, path, bob, block.timestamp + 1600);
        vm.stopPrank();
              
    }
}
 
