TradeImpl.sol : 

pragma solidity >=0.5.1 <0.6.0;

import "./TradeInterface.sol";

/**
* @title Basic implementation contract for trade related operations.
*/
contract TradeImpl is TradeInterface {

    struct tradeStruct {
        bytes32 tradeId;
        address fromParty;
        address toParty;
        address owner;
        uint amount;
        uint tradeDate;
    }
    
    // mapping to store trade trade data , key => tradeId, value => tradeStruct
                mapping (bytes32 => tradeStruct) tradeList;
                
    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner(address _owner) {
        require(isOwner(_owner), "Ownable: caller is not the owner");
        _;
    }

   /**
    * @dev Adds a trade into mapping tradeList
    * _tradeId should be unique and it is used as key to store tradeStruct data into mapping
    * @param _tradeId : unique id for a particular trade
    * @param _fromParty : address of sender
    * @param _toParty : address of recepient 
    * @param _amount : trade amount
    * @param _tradeDate : trade date in unixtimestamp
    */
    function addTrade(
        bytes32 _tradeId, 
        address _fromParty, 
        address _toParty, 
        uint _amount, 
        uint _tradeDate
    ) external {
        
        tradeList[_tradeId] = tradeStruct(_tradeId,
            _fromParty,
            _toParty,
            msg.sender,
            _amount,
            _tradeDate);
        
        emit TradeCreated(
            _tradeId,
            _fromParty,
            _toParty,
            msg.sender,
            _amount,
            _tradeDate
        );            
    }
    
    /**
     * @dev Fetches a particular trade from mapping tradeList based on the _tradeId
     * @param _tradeId : unique trade id of a particular trade
     * @return bytes32 : trade id
     * @return address : address of sender
     * @return address : address of recepient
     * @return address : address of owner
     * @return uint : trade amount
     * @return uint : trade date in unixtimestamp
     */
    function getTrade(bytes32 _tradeId) public view returns (bytes32, 
        address, 
        address,
        address,
        uint,
        uint)
    { 
        return (
            tradeList[_tradeId].tradeId,
            tradeList[_tradeId].toParty,
            tradeList[_tradeId].fromParty,
            tradeList[_tradeId].owner,
            tradeList[_tradeId].amount,
            tradeList[_tradeId].tradeDate
        );
    }

    /**
     * @dev Adds a trade into mapping tradeList
     * @param _tradeId : unique trade id of a particular trade
     * @param _amount : trade amount 
     */
    function updateTrade(
        bytes32 _tradeId,
        uint _amount) external onlyOwner(tradeList[_tradeId].owner){
        
        tradeStruct storage trade = tradeList[_tradeId];
        trade.amount = _amount;
    } 

    /**
     * @dev Returns true if the caller is the current owner.
     * @param _owner : address of owner
     * @return sends a boolean based on owner is sender or not
     */
    function isOwner(address _owner) internal view returns (bool) {
        return msg.sender == _owner;
    }
}
