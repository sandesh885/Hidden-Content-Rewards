// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract HiddenContentRewards {

    address public owner;
    uint public rewardAmount = 100 * 10 ** 18; // Reward for discovering hidden content, in tokens (example: 100 tokens)
    mapping(address => bool) public claimedRewards; // Track if the user has already claimed the reward
    mapping(address => uint) public rewardsClaimed; // Track the number of rewards a user has claimed
    
    // Event emitted when a reward is claimed
    event RewardClaimed(address indexed player, uint rewardAmount, uint totalRewards);

    constructor() {
        owner = msg.sender; // The contract creator is the owner
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }

    // Function to allow game developer to set the reward amount
    function setRewardAmount(uint _rewardAmount) external onlyOwner {
        rewardAmount = _rewardAmount;
    }

    // Function to claim a reward for discovering hidden content
    function claimReward() external {
        require(!claimedRewards[msg.sender], "Reward already claimed");
        
        // Simulate verifying hidden content discovery (this could be extended with game logic)
        // For simplicity, we'll assume any player can claim a reward once for discovery.

        // Mark as claimed and log the total rewards
        claimedRewards[msg.sender] = true;
        rewardsClaimed[msg.sender]++;

        // Emit an event when a reward is claimed
        emit RewardClaimed(msg.sender, rewardAmount, rewardsClaimed[msg.sender]);

        // Transfer the reward (Assuming the contract holds tokens for simplicity)
        // You need to integrate this with your token contract for actual transfers
        // Example:
        // IERC20(tokenAddress).transfer(msg.sender, rewardAmount);
    }

    // Function to withdraw tokens from the contract (only owner)
    function withdrawTokens(address token, uint amount) external onlyOwner {
        // Example ERC-20 withdrawal logic
        IERC20(token).transfer(owner, amount);
    }

    // Function to check if a player has claimed their reward
    function hasClaimedReward(address player) external view returns (bool) {
        return claimedRewards[player];
    }
}

// Interface for the ERC-20 token (assuming ERC-20 reward system)
interface IERC20 {
    function transfer(address recipient, uint256 amount) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
}
