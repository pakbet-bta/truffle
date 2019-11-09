pragma solidity ^0.5.11;

import "./pakbet_issuer.sol";

contract PakbetTemplate is PakbetIssuer {
    
    /**
     * @notice Creates blank certificates which will become basis for certificates
     * to be issued.
     * @dev Only account in the issuer[] array can call this function.
     * @param _title certificate description e.g. Certificate of Attendance.
     * @param _description certificate description e.g. BTA Expert Program
     */
    function createTemplate(string calldata  _title, string calldata _description) external isAccredited(msg.sender) {
        uint256 index = addressToIssuer[msg.sender];
        bytes32 hashCode = keccak256(abi.encode(_title, _description, issuers[index].name));
        _createTemplate(msg.sender, _title, _description, hashCode);
    }
    
     /**
      * @param _id uint256 value corresponding to the index position of the training institution
      * @return an array containing the template ids created template by the institution 
     */
    function getIssuedTemplates(uint256 _id) external view onlyOwner returns(uint256[] memory)  {
        require(_id < issuers.length);
        uint256[] memory result = new uint256[](issuers[_id].templatesCreated.length);
        
        for (uint i = 0; i < issuers[_id].templatesCreated.length; i++) {
            result[i] = issuers[_id].templatesCreated[i];
        }
        return result;
    }

    function _createTemplate(
        address _creator, 
        string memory _title, 
        string memory _description, 
        bytes32 _hashCode
    )
        internal isNotExistingTemplate(_hashCode) 
    {
        uint256 id = templates.length++;
        uint256 index = addressToIssuer[_creator];
        
        require (issuers[index].active);
        
        templates[id].createdBy = _creator;
        templates[id].title = _title;
        templates[id].description = _description;
        
        issuers[index].templatesCreated.push(id);
        existingTemplates[_hashCode] = true;
        emit NewTemplate(_creator, _title, _description);
    }
}
