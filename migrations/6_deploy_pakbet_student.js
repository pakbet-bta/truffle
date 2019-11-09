const pakbet_student = artifacts.require("PakbetStudent");

module.exports = function(deployer) {
  deployer.deploy(pakbet_student);
};
