// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

contract HandleVote {
    struct CandidateDetail {
        string name;
        uint votesCount;} 

    struct VoteResult {
        bytes32 serialNo; 
        string candidateName; 
    }

    mapping(uint256 => bool) private cnicVotes; 
    mapping(uint => CandidateDetail) internal candidates;
    mapping(bytes32 => bool) public votesCount; 
    mapping(bytes32 => CandidateDetail) public voteRecords;

    bytes32[] public serialNumbers; 
    address owner;
    uint public candidateCount; 

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "You have no authority");
        _;
    }

    function addCandidate(string memory _name) public onlyOwner {
        candidates[candidateCount] = CandidateDetail(_name, 0);
        candidateCount++;
    }

    function balletPaper(bytes32 _serialno, uint256 _cnic, uint _i) public {
        require(!votesCount[_serialno], "Serial number already used"); 
        require(bytes(candidates[_i].name).length > 0, "Invalid candidate index"); 
        require(!cnicVotes[_cnic], "CNIC is already present, sorry."); 
        
        cnicVotes[_cnic] = true; 
        votesCount[_serialno] = true; 
        candidates[_i].votesCount++; 
        voteRecords[_serialno] = candidates[_i]; 
        serialNumbers.push(_serialno);
    }

    function getCandidate(uint _index) public view returns (CandidateDetail memory) {
        require(_index < candidateCount, "Candidate does not exist");
        return candidates[_index];
    }

    function getVoteRecord(bytes32 _serialno) public view returns (CandidateDetail memory) {
        require(votesCount[_serialno], "Serial number has not voted"); 
        return voteRecords[_serialno]; 
    }

    function getResult() public view returns (VoteResult[] memory) {
        uint length = serialNumbers.length;
        VoteResult[] memory results = new VoteResult[](length);

        for (uint i = 0; i < length; i++) {
            bytes32 serial = serialNumbers[i];
            string memory candidateName = voteRecords[serial].name;
            results[i] = VoteResult(serial, candidateName);
        }

        return results;
    }
}
