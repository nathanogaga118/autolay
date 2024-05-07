// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/AutoLayerForwarder.sol";

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
