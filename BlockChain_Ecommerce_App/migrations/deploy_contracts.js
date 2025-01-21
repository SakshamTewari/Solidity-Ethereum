const Dai = require('../contracts/Dai.sol');
const PaymentProcessor = require('../contracts/PaymentProcessor.sol');

module.exports = async function (deployer, network, addresses) {
  // get addresses for admin, payer (out of 10 addresses)
  const [admin, payer, _] = addresses;

  if (network === 'develop') {
    await deployer.deploy(Dai);
    const dai = await Dai.deployed();
    // when we specify a transfer, we always talk in terms of 'wei' and not 'whole token' or 'whole ether'
    await dai.faucet(payer, web3.utils.toWei('10000'));
    // 1 DAI token = 1 * 10 * 18 "dai wei"
    // 1 Ether = 1 * 10 * 18 "ether wei"

    await deployer.deploy(PaymentProcessor, admin.dai.address);
  }
};
