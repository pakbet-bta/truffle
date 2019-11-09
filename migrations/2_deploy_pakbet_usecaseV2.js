const pakbet_usecaseV2 = artifacts.require("PakbetUsecase");

module.exports = function(deployer) {
  deployer.deploy(pakbet_usecaseV2);
};
