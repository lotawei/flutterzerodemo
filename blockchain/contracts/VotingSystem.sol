// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract VotingSystem {
    struct Proposal {
        string title;
        string description;
        uint256 voteCount;
        uint256 endTime;
        bool isActive;
    }

    struct Vote {
        bool hasVoted;
        uint256 proposalId;
    }

    address public owner;
    Proposal[] public proposals;
    mapping(address => mapping(uint256 => Vote)) public votes;

    event ProposalCreated(uint256 proposalId, string title, uint256 endTime);
    event Voted(address voter, uint256 proposalId);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    function createProposal(string memory _title, string memory _description, uint256 _durationInMinutes) public onlyOwner {
        require(_durationInMinutes > 0, "Duration must be greater than 0");
        
        proposals.push(Proposal({
            title: _title,
            description: _description,
            voteCount: 0,
            endTime: block.timestamp + (_durationInMinutes * 1 minutes),
            isActive: true
        }));

        emit ProposalCreated(proposals.length - 1, _title, block.timestamp + (_durationInMinutes * 1 minutes));
    }

    function vote(uint256 _proposalId) public {
        require(_proposalId < proposals.length, "Invalid proposal ID");
        require(proposals[_proposalId].isActive, "Proposal is not active");
        require(block.timestamp < proposals[_proposalId].endTime, "Voting period has ended");
        require(!votes[msg.sender][_proposalId].hasVoted, "Already voted");
        proposals[_proposalId].voteCount++;
        votes[msg.sender][_proposalId] = Vote(true, _proposalId);

        emit Voted(msg.sender, _proposalId);
    }

    function getProposal(uint256 _proposalId) public view returns (
        string memory title,
        string memory description,
        uint256 voteCount,
        uint256 endTime,
        bool isActive
    ) {
        require(_proposalId < proposals.length, "Invalid proposal ID");
        Proposal memory proposal = proposals[_proposalId];
        return (
            proposal.title,
            proposal.description,
            proposal.voteCount,
            proposal.endTime,
            proposal.isActive
        );
    }

    function getProposalsCount() public view returns (uint256) {
        return proposals.length;
    }

    function closeProposal(uint256 _proposalId) public onlyOwner {
        require(_proposalId < proposals.length, "Invalid proposal ID");
        proposals[_proposalId].isActive = false;
    }
}