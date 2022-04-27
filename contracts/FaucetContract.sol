// SPDX-Licence-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./Owned.sol";
import "./Logger.sol";
import "./IFaucet.sol";

contract Faucet is Owned, Logger, IFaucet {
    uint256 public numOfFunders;

    mapping(address => bool) private funders;
    mapping(uint256 => address) private lutFunders;

    modifier limitWithdraw(uint256 withdrawAmount) {
        require(
            withdrawAmount <= 2000000000000000000,
            "Cannot withdraw more than 2ETH"
        );
        _;
    }

    receive() external payable {}

    function emitLog() public override pure returns(bytes32) {
        return "Hello word";
    }

    function addFunds() external payable {
        address funder = msg.sender;
        if (!funders[funder]) {
            uint256 index = numOfFunders++;
            funders[funder] = true;
            lutFunders[index] = funder;
        }
    }

    function test1() external onlyOwner {
        // management only access
    }

    function test2() external onlyOwner {
        // management only access
    }

    function withdraw(uint256 withdrawAmount) override external limitWithdraw(withdrawAmount) {
        payable(msg.sender).transfer(withdrawAmount);
    }

    function getAllFunders() external view returns (address[] memory) {
        address[] memory _funders = new address[](numOfFunders);
        for (uint256 i = 0; i < numOfFunders; i++) {
            _funders[i] = lutFunders[i];
        }
        return _funders;
    }

    function getFunderAtIndex(uint8 index) public view returns (address) {
        return lutFunders[index];
    }
}

/*
    truffle migrate --reset
    truffle console
    const instance = await Faucet.deployed();
    instance.addFunds({from: accounts[0], value: "2000000000000000000"});
    instance.addFunds({from: accounts[1], value: "2000000000000000000"});
    instance.addFunds({from: accounts[3], value: "2000000000000000000"});
    
    Error test
    instance.withdraw("20000000000000000000", {from: accounts[3]});
    instance.test1({from: accounts[1]});

    Correct Test
    instance.test1();
    instance.withdraw("2000000000000000000", {from: accounts[3]});
    instance.addFunds({from: accounts[1], value: "20000000000000000000"});
    instance.getFunderAtIndex(0);
    instance.getAllFunders();
*/
