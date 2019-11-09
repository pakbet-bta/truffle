pragma solidity ^0.5.0;

import "./ownable.sol";

contract PakbetUseCase is Ownable {
    event NewTemplate(address issuerAddress, string title, string description);
    event NewCertificate(bytes32 hashCode);
    event NewPremiumCertificate(bytes32 hashCode, address student);
    event NewIssuer(uint issuerId, string name);
    event NewStudent(uint256 id, address student);
    
    struct Issuer {
        bool active;
        string name;
        uint256[] templatesCreated;
    }

    struct Template {
       address createdBy;
       string title;
       string description;
    }
    
    struct Certificate {
        uint256 issuedTo;
        uint256 issuedBy;
        uint256 templateUsed;
        uint32 date;
    }
    
    struct Student {
        address blockChainAccount;
        uint256[] certificatesOwned;
    }
    
    Certificate[] public certificates;
    Issuer[] public issuers;
    Student[] public students;
    Template[] public templates;

    mapping (address => bool) premiumStudents;
    mapping (address => bool) accreditedIssuers;
    mapping (address => uint256) addressToIssuer;
    mapping (address => uint256) addressToStudent;
    mapping (bytes32 => uint256) bytesToCertificate;
    mapping (bytes32 => bool) existingTemplates;
    mapping (bytes32 => bool) premiumCertificates;
    mapping (bytes32 => bool) regularCertificates;
    
    
    modifier isNotAccredited(address _issuerAddress) {
        require(!accreditedIssuers[_issuerAddress]);
        _;
    }
    
    modifier isAccredited(address _issuerAddress) {
        require(accreditedIssuers[_issuerAddress]);
        _;
    }
    
    modifier isNotExistingTemplate(bytes32 _hashCode) {
        require(!existingTemplates[_hashCode]);
        _;
    }
    
    modifier isExistingTemplate(bytes32 _hashCode) {
        require(existingTemplates[_hashCode]);
        _;
    }
    
    modifier canAward(address _issuer) {
        uint256 index = addressToIssuer[_issuer];
        
        require(accreditedIssuers[_issuer]);
        require (issuers[index].active);
        _;
    }
}
