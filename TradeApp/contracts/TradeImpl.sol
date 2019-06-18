pragma solidity >=0.5.1 <0.6.0;

import "./TradeInterface.sol";

contract TradeImpl is TradeInterface {
    
    event TradeCreated(bytes32 _tradeId, address _fromParty, address _toParty, uint _amount, uint _tradeDate);

    
    struct tradeStruct {
        bytes32 tradeId;
        address fromParty;
        address toParty;
        uint amount;
        uint tradeDate;
    }
    
	mapping (bytes32 => tradeStruct) tradeList;
	
    function  addTrade(bytes32 _tradeId, address _fromParty, address _toParty, uint _amount, uint _tradeDate) external {
        tradeList[_tradeId] = tradeStruct(_tradeId,_fromParty,_toParty,_amount,_tradeDate);
        emit TradeCreated(_tradeId,_fromParty,_toParty,_amount,_tradeDate);            
    }
    
    function getTrade(bytes32 _tradeId) public view returns (address, address, uint, uint)
    {
        return (tradeList[_tradeId].toParty, tradeList[_tradeId].fromParty, tradeList[_tradeId].amount,tradeList[_tradeId].tradeDate);
    }

}

