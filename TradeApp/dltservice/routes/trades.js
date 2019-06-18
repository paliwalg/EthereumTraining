var express = require('express');
var router = express.Router();
const Web3 = require('web3');
const tradeInterface = require("../../build/contracts/TradeInterface").abi;
console.log(tradeInterface);

const web3js = new Web3(new Web3.providers.HttpProvider("http://localhost:8545"));
const contractAddress = '0x3b8575226b7EF47007e42196BA4645bDA1fEb6d4';
const accountAddress = '0x26499c1635e421fe79249396e97fa8f9f21f6615' ;

/* Post a trade. */
router.post('/', function(req, res, next) {

  var contract = new web3js.eth.Contract(tradeInterface,contractAddress);
 contract.methods.addTrade(
                        web3js.utils.asciiToHex('TD123'),
                        '0xcd0d32aef4ac687b6ea5e362a6ab8c515da836ce',
                        '0xe0f80cf8705854f17a355d45bb7ad196650d8064',
                        1000,
                        1561104000).send({from: accountAddress,gas: 3000000})
.on('transactionHash', (hash) => {
    console.log('TxHash is :' + hash);
    res.send({"TxHash":hash});
})
.on('confirmation', (confirmationNumber, receipt) => {
    console.log('confirmation handler');
    console.log('ConfirmationNumber is :' + confirmationNumber)
    console.log ('Receipt is : ' + JSON.stringify(receipt));
})
.on('receipt', (receipt) => {
   console.log('receipt handler');
    console.log(receipt);
})
.on('error', console.error); 

 /*.send({from: accountAddress,gas: 3000000}, (error, transactionHash) => {
                        res.send('Transaction Hash is :' + transactionHash);
});
*/
});


/* GET specific trade. */
router.get('/', function(req, res, next) {
  var contract = new web3js.eth.Contract(tradeInterface,contractAddress);

  contract.methods.getTrade(web3js.utils.asciiToHex('TD123')).call()
          .then((result) => {
          console.log(result);
   var trade = {
       "fromParty" : result[0],
       "toParty" : result[1],
       "amount" : result[2].toNumber(),
       "tradeDate": result[3].toNumber() 
   }
   res.send( trade);
});

});

module.exports = router;
