const pakbet_issuer = artifacts.require("PakbetIssuer");

module.exports = function(deployer) {
  deployer.deploy(pakbet_issuer);
};
