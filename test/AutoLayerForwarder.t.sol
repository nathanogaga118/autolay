// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "../src/AutoLayerForwarder.sol";
import "../src/Ownable.sol"; // Import Ownable.sol if it's not already imported
import "../src/SafeERC20.sol"; // Import SafeERC20.sol if it's not already imported
import "../src/AggregatorV3Interface.sol"; // Import AggregatorV3Interface.sol if it's not already imported
import "../src/IERC20.sol"; // Import IERC20.sol if it's not already imported
import "../src/IParaSwap.sol"; // Import IParaSwap.sol if it's not already imported
import "../src/IBalancer.sol"; // Import IBalancer.sol if it's not already imported

import "forge-std/Test.sol";

contract AutoLayerForwarderTest is Test {
    AutoLayerForwarder forwarder;
    address owner;

    function setUp() public {
        owner = address(this);
        forwarder = new AutoLayerForwarder(
            address(0), // autoLayerPointsAddress
            address(0), // routerAddress
            address(0), // ETHUSDPriceFeedAddress
            address(0), // balancerVaultAddress
            address(0)  // tokenProxyAddress
        );
        forwarder.transferOwnership(owner);
    }

    function testWhitelistZeroAddress() public {
        address[] memory tokenAddresses = new address[](1);
        tokenAddresses[0] = address(0);

        vm.expectRevert("Zero address not allowed");
        forwarder.whitelistTokens(tokenAddresses);
    }

    function testWhitelistNonZeroAddress() public {
        address[] memory tokenAddresses = new address[](1);
        tokenAddresses[0] = address(1);

        vm.prank(owner);
        forwarder.whitelistTokens(tokenAddresses);

        assertTrue(forwarder.isTokenWhitelisted(address(1)));
    }
}
