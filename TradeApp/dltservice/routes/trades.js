var express = require('express');
var router = express.Router();
const Web3 = require('web3');
const tradeInterface = require("../../build/contracts/TradeInterface").abi;
const contractAddress = require("../../build/contracts/TradeImpl").networks["123"].address;
const web3js = new Web3(new Web3.providers.HttpProvider("http://localhost:8545"));
let senderEthAddress;


/* Post a trade. */
router.post('/', function (req, res, next) {

    var contract = new web3js.eth.C ontract(tradeInterface, contractAddress);
    contract.methods.addTrade(
        web3js.utils.asciiToHex(req.body.tradeId), req.body.fromParty, req.body.toParty,
        req.body.amount, new Date(req.body.tradeDate)/1000)
        .send({ from: senderEthAddress, gas: 3000000 })
        .on('transactionHash', (hash) => {
            console.log('TxHash is :' + hash);
            res.send({ "TxHash": hash });
        })
        .on('confirmation', (confirmationNumber, receipt) => {
            console.log('ConfirmationNumber is :' + confirmationNumber)
            console.log('Receipt is : ' + JSON.stringify(receipt));
        })
        .on('error', console.error);

});


/* GET specific trade. */
router.get('/:tradeId', function (req, res, next) {
    var contract = new web3js.eth.Contract(tradeInterface, contractAddress);
    console.log(req.params.tradeId);
    contract.methods.getTrade(web3js.utils.asciiToHex(req.params.tradeId)).call()
        .then((result) => {
            var trade = {
                "fromParty": result[0],
                "toParty": result[1],
                "amount": result[2].toNumber(),
                "tradeDate": new Date(result[3].toNumber()*1000).toLocaleString()
            };
            res.send(trade);
        });

});

web3js.eth.getAccounts((err, accs) => {
    if (err != null) {
        console.log("error is" + err);
    }
    senderEthAddress = accs[0];
});


module.exports = router;
