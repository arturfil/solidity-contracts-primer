// SPDX-Licence-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

// they cannot inherit from other smart contracts
// they can only inherit from other interfaces

// They cannot declare an contructor
// all declared functions have to be external

interface IFaucet {
    function addFunds() external payable;
    function withdraw(uint256 withdrawAmount) external;
}