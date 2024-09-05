// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

contract HandleVote {
    struct CandidateDetail {
        string name;
        uint votesCount; // Track the number of votes for each candidate
    }

    struct VoteResult {
        bytes32 serialNo; // Serial number of the vote
        string candidateName; // Name of the candidate voted for
    }

    mapping(uint256 => bool) private cnicVotes; // Mapping to track used CNICs
    mapping(uint => CandidateDetail) internal candidates;
    mapping(bytes32 => bool) public votesCount; 
    mapping(bytes32 => CandidateDetail) public voteRecords;

    bytes32[] public serialNumbers; // Array to track all serial numbers used for voting
    address owner;
    uint public candidateCount; // Counter to track the number of candidates

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
        require(!votesCount[_serialno], "Serial number already used"); // Ensure serial number hasn't voted
        require(bytes(candidates[_i].name).length > 0, "Invalid candidate index"); // Ensure candidate exists
        require(!cnicVotes[_cnic], "CNIC is already present, sorry."); // Check if CNIC is already used
        
        cnicVotes[_cnic] = true; // Mark CNIC as used
        votesCount[_serialno] = true; // Mark this serial number as having voted
        candidates[_i].votesCount++; // Increment the vote count of the candidate
        voteRecords[_serialno] = candidates[_i]; // Record the candidate details associated with this serial number
        serialNumbers.push(_serialno); // Add serial number to the array for tracking
    }

    // Function to get candidate details
    function getCandidate(uint _index) public view returns (CandidateDetail memory) {
        require(_index < candidateCount, "Candidate does not exist");
        return candidates[_index];
    }

    // Function to get which candidate a serial number voted for
    function getVoteRecord(bytes32 _serialno) public view returns (CandidateDetail memory) {
        require(votesCount[_serialno], "Serial number has not voted"); // Ensure the serial number has voted
        return voteRecords[_serialno]; 
    }

    // Function to show the results with serial numbers and corresponding candidate names
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
