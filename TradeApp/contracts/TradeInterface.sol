pragma solidity >=0.5.1 <0.6.0;

/**
* @title Required interface for Trade related operations.
*/
interface TradeInterface {
    
    // Event fired after trade is added into the mapping
    event TradeCreated(
        bytes32 _tradeId, 
        address _fromParty, 
        address _toParty,
        address _owner,
        uint _amount, 
        uint _tradeDate);
    
    /**
     * @dev Adds a trade into mapping tradeList
     * _tradeId should be unique and it is used as key to store tradeStruct data into mapping 
     * @param _tradeId : unique id for a particular trade
     * @param _fromParty : address of sender
     * @param _toParty : address of recepient 
     * @param _amount : trade amount
     * @param _tradeDate : trade date in unixtimestamp 
     */
    function  addTrade(
        bytes32 _tradeId, 
        address _fromParty, 
        address _toParty, 
        uint _amount, 
        uint _tradeDate) external;

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
    function getTrade(
        bytes32 _tradeId) external view returns (bytes32,
        address,
        address,
        address,
        uint,
        uint);

    /**
     * @dev Adds a trade into mapping tradeList
     * @param _tradeId : unique trade id of a particular trade
     * @param _amount : trade amount 
     */
    function updateTrade(
       bytes32 _tradeId,
        uint _amount) external;
}
