// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "../interfaces/IBalancer.sol";

library AutoLayerUtils {
    function generateAmounts(uint256 swappedAmount, address[] memory tokens_, address depositedToken) internal pure returns (uint256[] memory amounts) {
        amounts = new uint256[](tokens_.length);
        for (uint i = 0; i < tokens_.length; i++) {
            if (tokens_[i] == depositedToken) amounts[i] = swappedAmount;
            else amounts[i] = 0;
        }
    }

    function tokensToAssets(address[] memory tokens_) internal pure returns(IAsset[] memory assets) {
        assets = new IAsset[](tokens_.length);
        for (uint8 i = 0; i < tokens_.length; i++) {
            assets[i] = IAsset(tokens_[i]);
        }
    }
}
