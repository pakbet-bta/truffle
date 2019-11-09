pragma solidity ^0.5.0;

import "./PakbetUsecase.sol";

contract PakbetIssuer is PakbetUseCase {
    
    /**
     * @return the number of accredited institution
     */ 
    function getIssuerCount() external view onlyOwner returns (uint256) {
        return issuers.length;
    }

    /**
     * @notice Add training institution to the blockchain.
     * @dev Only the owner of the smart contract account can call this function. 
     * @param _issuerAddress Blockchain Address associated to the training institution.
     * @param _name Name of the training institution.
     */
<<<<<<< HEAD:contracts/PakbetIssuer.sol
    function accreditIssuer(address _issuerAddress, string calldata _name) external onlyOwner {
=======
    function accreditIssuer(address _issuerAddress, string calldata  _name) external onlyOwner {
>>>>>>> 7becc0d07fce5c3df516b22d6e4e01fe936afc67:contracts/pakbet_issuer.sol
        _accreditIssuer(_issuerAddress, _name);
    }
    
    /**
     * @notice Prevent a training institution from creating and awarding certificates.
     * @param _index uint256 value corresponding to the index position of the training institution
     * in the issuers[] array.
     */ 
    function deActivateIssuerById(uint256 _index) external onlyOwner {
        require(issuers[_index].active);
        issuers[_index].active = false;
    }

    /**
     * @notice Allows a training institution from creating and awarding certificates.
     * @param _index uint256 value corresponding to the index position of the training institution
     * in the issuers[] array.
     */ 
    function reActivateIssuerById(uint256 _index) external onlyOwner {
        require(!issuers[_index].active);
        issuers[_index].active = true;
    }
    
<<<<<<< HEAD:contracts/PakbetIssuer.sol
    function _accreditIssuer(address _issuerAddress, string memory _name) internal isNotAccredited(_issuerAddress) {
=======
    function _accreditIssuer(address _issuerAddress, string memory  _name) internal isNotAccredited(_issuerAddress) {
>>>>>>> 7becc0d07fce5c3df516b22d6e4e01fe936afc67:contracts/pakbet_issuer.sol
        uint256 id = issuers.length++;
        
        issuers[id].active = true;
        issuers[id].name = _name;
        
        accreditedIssuers[_issuerAddress] = true;
        addressToIssuer[_issuerAddress] = id;
        emit NewIssuer(id, _name);
    }
}
