pragma solidity >=0.5.1 <0.6.0;

interface TradeInterface {
    
    event TradeCreated(bytes32 _tradeId, address _fromParty, address _toParty, uint _amount, uint _tradeDate);

    function  addTrade(bytes32 _tradeId, address _fromParty, address _toParty, uint _amount, uint _tradeDate) external;

    function getTrade(bytes32 _tradeId) external view returns (address, address, uint, uint);

}

