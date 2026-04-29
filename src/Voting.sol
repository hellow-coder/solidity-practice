// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Voting {

    // ─── Structs ────────────────────────────────
    struct Candidate {
        string name;
        uint256 voteCount;
    }

    // ─── State Variables ────────────────────────
    Candidate[] public candidates;
    address public owner;
    mapping(address => bool) public hasVoted;
    bool public votingOpen;

    // ─── Events ─────────────────────────────────
    event Voted(address indexed voter, uint256 candidateIndex);
    event VotingStarted();
    event VotingStopped();

    // ─── Modifiers ──────────────────────────────
    modifier onlyOwner() {
        require(msg.sender == owner, "Sirf owner kar sakta hai!");
        _;
    }

    modifier isVotingOpen() {
        require(votingOpen == true, "Voting band hai!");
        _;
    }

    // ─── Constructor ────────────────────────────
    constructor(string[] memory _candidateNames) {
        owner = msg.sender;
        votingOpen = false;

        for (uint256 i = 0; i < _candidateNames.length; i++) {
            candidates.push(
                Candidate({
                    name: _candidateNames[i],
                    voteCount: 0
                })
            );
        }
    }

    // ─── Functions ──────────────────────────────
    function startVoting() external onlyOwner {
        votingOpen = true;
        emit VotingStarted();
    }

    function stopVoting() external onlyOwner {
        votingOpen = false;
        emit VotingStopped();
    }

    function vote(uint256 _candidateIndex) external isVotingOpen {
        require(!hasVoted[msg.sender], "Tum pehle se vote de chuke ho!");
        require(_candidateIndex < candidates.length, "Invalid candidate!");

        candidates[_candidateIndex].voteCount++;
        hasVoted[msg.sender] = true;

        emit Voted(msg.sender, _candidateIndex);
    }

    function getCandidate(uint256 _index) external view returns (string memory, uint256) {
        return (candidates[_index].name, candidates[_index].voteCount);
    }

    function getTotalCandidates() external view returns (uint256) {
        return candidates.length;
    }

    function getWinner() external view returns (string memory winnerName, uint256 winnerVotes) {
        require(!votingOpen, "Voting abhi band nahi hui!");
        require(candidates.length > 0, "Koi candidate nahi hai!");

        uint256 highestVotes = 0;
        uint256 winnerIndex = 0;

        for (uint256 i = 0; i < candidates.length; i++) {
            if (candidates[i].voteCount > highestVotes) {
                highestVotes = candidates[i].voteCount;
                winnerIndex = i;
            }
        }

        winnerName = candidates[winnerIndex].name;
        winnerVotes = candidates[winnerIndex].voteCount;
    }
}