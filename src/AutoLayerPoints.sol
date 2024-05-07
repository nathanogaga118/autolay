// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/access/Ownable.sol";

contract AutoLayerPoints is Ownable {

    mapping(address => uint256) public userPoints;
    mapping(address => bool) public isAllowed;

    event AutoLayerPointsAdded(address user, uint256 pointsAdded);
    event AutoLayerPointsRemoved(address user, uint256 pointsAdded);

    modifier onlyAllowed() {
        require(isAllowed[msg.sender] || msg.sender == owner(), "Not allowed forwarder");
        _;
    }

    constructor() Ownable(msg.sender) {}

    function setAllowed(address allowedAddress_) public onlyOwner() {
        isAllowed[allowedAddress_] = true;
    }

    function removeAllowed(address notAllowedAddress_) public onlyOwner() {
        isAllowed[notAllowedAddress_] = false;
    }

    function addPoints(address userAddress_, uint256 pointsAmount_) public onlyAllowed() {
        userPoints[userAddress_] += pointsAmount_;
        emit AutoLayerPointsAdded(userAddress_, pointsAmount_);
    }

    function removePoints(address userAddress_, uint256 pointsAmount_) public onlyAllowed() {
        userPoints[userAddress_] -= pointsAmount_;
        emit AutoLayerPointsRemoved(userAddress_, pointsAmount_);
    }
}
