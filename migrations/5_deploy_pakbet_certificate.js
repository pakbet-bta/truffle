const pakbet_certificate = artifacts.require("PakbetCertificate");

module.exports = function(deployer) {
  deployer.deploy(pakbet_certificate);
};
