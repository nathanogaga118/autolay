// SPDX-License-Identifier: MIT

pragma solidity ^0.8.6;

library Utils {

struct SimpleData {
    address fromToken;
    address toToken;
    uint256 fromAmount;
    uint256 toAmount;
    uint256 expectedAmount;
    address[] callees;
    bytes exchangeData;
    uint256[] startIndexes;
    uint256[] values;
    address payable beneficiary;
    address payable partner;
    uint256 feePercent;
    bytes permit;
    uint256 deadline;
    bytes16 uuid;
}

struct SellData {
    address fromToken;
    uint256 fromAmount;
    uint256 toAmount;
    uint256 expectedAmount;
    address payable beneficiary;
    Utils.Path[] path;
    address payable partner;
    uint256 feePercent;
    bytes permit;
    uint256 deadline;
    bytes16 uuid;
}

struct Path {
    address to;
    uint256 totalNetworkFee; //NOT USED - Network fee is associated with 0xv3 trades
    Adapter[] adapters;
}

struct Adapter {
    address payable adapter;
    uint256 percent;
    uint256 networkFee; //NOT USED
    Route[] route;
}

struct Route {
    uint256 index; //Adapter at which index needs to be used
    address targetExchange;
    uint256 percent;
    bytes payload;
    uint256 networkFee; //NOT USED - Network fee is associated with 0xv3 trades
}
}
