truffle migrate --reset
truffle console
const instance = await Faucet.deployed();
instance.addFunds({from: accounts[0], value: "2000000000000000000"});
instance.addFunds({from: accounts[1], value: "2000000000000000000"});
instance.addFunds({from: accounts[1], value: "2000000000000000000"});
instance.withdraw("200000000000000000", {from: accounts[0]});
instance.withdraw({from: accounts[1], value: "2000000000000000000"});
instance.getFunderAtIndex(0);
instance.getAllFunders();