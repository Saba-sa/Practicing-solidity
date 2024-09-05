// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract VotingSystem {
    address public owner;
    mapping(address => bool) internal alreadyVoted;

    struct Candidate {
        string name;
        uint voteCount;
    }

    constructor() {
        owner = msg.sender;
    }

    modifier hasVoted() {
        require(!alreadyVoted[msg.sender], "You have already voted.");
        _;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "You have no authority");
        _;
    }

    mapping(uint => Candidate) internal candidates;
    uint public candidatesCount;

    function addCandidates(string memory _name) public onlyOwner {
        candidatesCount++;
        candidates[candidatesCount] = Candidate(_name, 0);
    }

    function Seecandidatedetail(
        uint _id
    ) public view returns (string memory name) {
        Candidate memory candidate = candidates[_id];
        return candidate.name;
    }

    function vote(uint _idofCandidate) public hasVoted {
        alreadyVoted[msg.sender] = true;
        Candidate storage candidate = candidates[_idofCandidate];
        candidate.voteCount++;
    }

    function seewhoWon()
        public
        view
        returns (string memory winnerName, uint winnerVoteCount)
    {
        uint winningVoteCount = 0;
        uint winningCandidateId = 0;

        for (uint i = 1; i <= candidatesCount; i++) {
            if (candidates[i].voteCount > winningVoteCount) {
                winningVoteCount = candidates[i].voteCount;
                winningCandidateId = i;
            }
        }

        if (winningCandidateId == 0) {
            return ("No candidates", 0);
        }

        return (
            candidates[winningCandidateId].name,
            candidates[winningCandidateId].voteCount
        );
    }
}
