// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import "./ExternalContract.sol"; // Ensure you have the correct path to the external contract

contract HandleVote {
    struct CandidateDetail {
        string name;
    }

    uint256[] internal arryOfCNICSVotes;
    mapping(uint => CandidateDetail) internal candidates;
    mapping(bytes32 => bool) public votesCount; 
    mapping(bytes32 => CandidateDetail) public voteRecords;

    ExternalContract externalContract;

    constructor(address _externalContractAddress) {
        externalContract = ExternalContract(_externalContractAddress);
    }

    // Add a candidate to the mapping
    function addCandidate(uint _index, string memory _name) public {
        candidates[_index] = CandidateDetail(_name);
    }

    // Function to record a vote
    function balletPaper(bytes32 _serialno, uint _i) public {
        require(!votesCount[_serialno], "Serial number already used"); // Ensure serial number hasn't voted
        require(bytes(candidates[_i].name).length > 0, "Invalid candidate index"); // Ensure candidate exists

        votesCount[_serialno] = true; // Mark this serial number as having voted

        // Record the candidate details associated with this serial number
        voteRecords[_serialno] = candidates[_i];
    }

    // Function to get candidate details
    function getCandidate(uint _index) public view returns (CandidateDetail memory) {
        return candidates[_index];
    }

    // Function to get which candidate a serial number voted for
    function getVoteRecord(bytes32 _serialno) public view returns (CandidateDetail memory) {
        require(votesCount[_serialno], "Serial number has not voted"); // Ensure the serial number has voted
        return voteRecords[_serialno]; // Return the CandidateDetail struct
    }

    // Function to get CNIC and serial number from the external contract
    function getCNICAndSerial(bytes32 _serialno) public view returns (uint256, bytes32) {
        return externalContract.sha(_serialno);
    }
}
