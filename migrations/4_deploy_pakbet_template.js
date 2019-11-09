const pakbet_template = artifacts.require("PakbetTemplate");

module.exports = function(deployer) {
  deployer.deploy(pakbet_template);
};
