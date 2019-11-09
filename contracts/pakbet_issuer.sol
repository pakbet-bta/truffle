pragma solidity ^0.5.11;

import "./pakbet_usecaseV2.sol";

contract PakbetIssuer is PakbetUseCase {

    /**
     * @notice Add training institution to the blockchain.
     * @dev Only the owner of the smart contract account can call this function. 
     * @param _issuerAddress Blockchain Address associated to the training institution.
     * @param _name Name of the training institution.
     */
    function accreditIssuer(address _issuerAddress, string calldata  _name) external onlyOwner {
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
    
    function _accreditIssuer(address _issuerAddress, string memory  _name) internal isNotAccredited(_issuerAddress) {
        uint256 id = issuers.length++;
        
        issuers[id].active = true;
        issuers[id].name = _name;
        
        accreditedIssuers[_issuerAddress] = true;
        addressToIssuer[_issuerAddress] = id;
        emit NewIssuer(id, _name);
    }
}
