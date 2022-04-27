// SPDX-Licence-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Faucet {
    
    uint public numOfFunders;
    mapping(address => bool) private funders;

    receive() external payable {}

    function addFunds() external payable {
        uint index = numOfFunders++;
        address funder = msg.sender;
        if (!funders[funder]) {
            numOfFunders++;
            funders[funder] = true;
        }
    }

    function getAllFunders() external view returns(address[] memory) {
        address[] memory _funders = new address[](numOfFunders);
        for (uint i = 0; i < numOfFunders; i++) {
            _funders[i] = funders[i];
        }
        return _funders;
    }

    function getFunderAtIndex(uint8 index) public view returns (address) {
        return funders[index];
    }
}

/*
    truffle migrate --reset
    truffle console
    const instance = await Faucet.deployed();
    instance.addFunds({from: accounts[0], value: "2000000000000000000"});
    instance.addFunds({from: accounts[1], value: "2000000000000000000"});
    instance.getFunderAtIndex(0);
    instance.getAllFunders();
*/
