const TradeImpl = artifacts.require("TradeImpl");

module.exports = function(deployer) {
  deployer.deploy(TradeImpl);
};
