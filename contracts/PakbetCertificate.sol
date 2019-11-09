pragma solidity ^0.5.0;
import "./PakbetTemplate.sol";

contract PakbetCertificate is PakbetTemplate {
    

    /**
     * @dev Record the hash value of the pdf document to the blockchain account.
     * @notice Only accredited account can call this function.
     * @return true if awarding of certificate is good, false if awarding of certificate fails.
     * @param _hashCode the resulting value when pdf is hashed.
     */
    function awardRegularCertificate(bytes32 _hashCode) external canAward(msg.sender) returns(bool) {
        require(!regularCertificates[_hashCode]);
        regularCertificates[_hashCode] = true;
        emit NewCertificate(_hashCode);
        return true;
    }
    
    /**
     * @return true if Certificate exist in the blockchain, false if not.
     * @param _hashCode the resulting value when pdf is hashed.
     */
    function validateRegularCertificate(bytes32 _hashCode) external view returns(bool) {
        return (regularCertificates[_hashCode] || premiumCertificates[_hashCode]);
    }
    
    /**
     * @param _templateId uint256 value corresponding to the index position of template in the templates[] array.
     * @param _hashCode the resulting value when pdf is hashed.
     * @param _studentAddress Blockchain Address associated to the student.
     */ 
    function awardPublicCertificates(
        uint256 _templateId, 
        bytes32 _hashCode, 
        address _studentAddress
    ) 
        external isAccredited(msg.sender) 
    {
        require(_templateId < templates.length);
        require(templates[_templateId].createdBy == msg.sender);
        require(premiumStudents[_studentAddress]);
        require(!premiumCertificates[_hashCode]);
        
        uint256 studentIndex = addressToStudent[_studentAddress];
        uint256 issuerIndex = addressToIssuer[msg.sender];
        
        uint256 id = certificates.push(Certificate(studentIndex, issuerIndex, _templateId, uint32(now))) - 1;
        premiumCertificates[_hashCode] = true;
        bytesToCertificate[_hashCode] = id;
        
        students[studentIndex].certificatesOwned.push(id);
    }
}
