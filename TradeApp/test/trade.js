const TradeImpl = artifacts.require("TradeImpl");

contract('TradeImpl', (accounts) => {
  it('Should deploy the contract at some address', async () => {
    const tradeInstance = await TradeImpl.deployed();
    assert.ok(tradeInstance.address);
  });

  it('Add a trade with tradeId TD123', async () => {
    const tradeInstance = await TradeImpl.deployed();
    const tradeDateUTC = (new Date('6/21/2019 12:00:00 PM GMT+0400')/1000);
    const amount = 1000;
    await tradeInstance.addTrade( web3.utils.asciiToHex('TD123'),accounts[0],accounts[1],amount,tradeDateUTC);

    let response = await tradeInstance.getTrade(web3.utils.asciiToHex('TD123'));
    const expected = `$(accounts[0]), $(accounts[1]),1000,$(tradeDateUTC)`;
    assert.equal(response[0],accounts[0],"from party not correct");
    assert.equal(response[1],accounts[1],"to party not correct");
    assert.equal(response[2].toNumber(),amount,"in correct amount");
    assert.equal(response[3].toNumber(),tradeDateUTC,"Trade date incorrect");
  });	

 
 });

