pragma solidity ^0.5.0;

import "./PakbetCertificate.sol";

contract PakbetStudent is PakbetCertificate {
    
    /**
     * @notice Add student to the blockchain.
     * @dev Only accredited account can call this function. 
     * @param _studentAddress Blockchain Address associated to the student.
     */ 
    function enrollStudent(address _studentAddress) external isAccredited(msg.sender) {
        require(!premiumStudents[_studentAddress]);
        _enrollStudent(_studentAddress);
    }
    
    /**
     * @param _id uint256 value corresponding to the index position of the student
     * in the students[] array.
     * @return an array containing the certificate ids owned by the student.
     */ 
    function getStudentCertificates(uint256 _id) external view returns(uint256[] memory) {
        require (students[_id].blockChainAccount == msg.sender);
        uint256[] memory result = new uint256[](students[_id].certificatesOwned.length);
        
        for (uint i = 0; i < students[_id].certificatesOwned.length; i++) {
            result[i] = students[_id].certificatesOwned[i];
        }
        return result;
    }
    
    function _enrollStudent(address _studentAccount) internal {
        uint256 id = students.length++;
        
        students[id].blockChainAccount = _studentAccount;
        premiumStudents[_studentAccount] = true;
        addressToStudent[_studentAccount] = id;
        emit NewStudent(id, _studentAccount);
   }
}

//Owner
//"0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c","Tutu Institute"

//Issuers
//"0x14723A09ACff6D2A60DcdF7aA4AFf308FDDC160C","Block Chain"
//"0x4B0897b0513fdC7C541B6d9D7E929C4e5364D2dB","Kadenang Bloke"

//Students
//"0x583031D1113aD414F02576BD6afaBfb302140225"
//"0xdD870fA1b7C4700F2BD7f44238821C26f7392148"

//Templates
//"Certificate of Completion","Blockchain Security"
//"Certificate of Attendance","BTA Excellarator"
//"Certificate of Participation","BTA Expert"
//"Certificate of Participation","Block Chain"
//"Certificate of Participation","Kadenang Bloke"


//Regular Certificate
//"0x4365727469666963617465206f662050617274696369706174696f6e0a4a6f00"
//"0x4365727469666963617465206f6620417474656e64616e63650a4a6f656c0000"
//"0x4365727469666963617465206f6620436f6d706c6574696f6e0a4a6f656c0000"

//Public Certificate
//0,"0x7465737400000000000000000000000000000000000000000000000000000000","0x583031D1113aD414F02576BD6afaBfb302140225"
//1,"0x6a6f656c00000000000000000000000000000000000000000000000000000000","0x583031D1113aD414F02576BD6afaBfb302140225" 
//2,"0x6a696d656e657a00000000000000000000000000000000000000000000000000","0x583031D1113aD414F02576BD6afaBfb302140225"
//3,"0x4a6f656c204b6164656e61206664642064206600000000000000000000000000","0xdD870fA1b7C4700F2BD7f44238821C26f7392148"
