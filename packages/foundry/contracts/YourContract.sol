//SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "forge-std/console.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

/// @title Simple Token Wallet Contract
/// @notice This contract allows users to deposit, withdraw, and track their ERC20 token balances.
/// @dev Only the contract owner can change ownership.

contract YourContract {
    /// @notice Address of the contract owner
    address public owner;

    /// @notice Mapping to track user token balances
    /// @dev userBalances[userAddress][tokenAddress] => balance
    mapping(address => mapping(address => uint256)) public userBalances;

    /// @notice Event emitted when tokens are deposited
    /// @param user The address of the user who deposited tokens
    /// @param token The address of the ERC20 token being deposited
    /// @param amount The amount of tokens deposited
    event Deposited(address indexed user, address indexed token, uint256 amount);

    /// @notice Event emitted when tokens are withdrawn
    /// @param user The address of the user who withdrew tokens
    /// @param token The address of the ERC20 token being withdrawn
    /// @param amount The amount of tokens withdrawn
    event Withdrawn(address indexed user, address indexed token, uint256 amount);

    /// @notice Modifier to restrict access to only the owner of the contract
    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    /// @notice Sets the contract deployer as the initial owner
    constructor() {
        owner = msg.sender;
    }

    /// @notice Allows a user to deposit ERC20 tokens into the contract
    /// @dev The user must first approve the contract to transfer tokens on their behalf
    /// @param _token The address of the ERC20 token to deposit
    /// @param _amount The amount of tokens to deposit
    function deposit(address _token, uint256 _amount) external {
        require(_amount > 0, "Amount must be greater than zero");
        IERC20 token = IERC20(_token);

        // Transfer tokens from the user to the contract
        require(token.transferFrom(msg.sender, address(this), _amount), "Token transfer failed");

        // Update the user's balance
        userBalances[msg.sender][_token] += _amount;

        // Emit the deposit event
        emit Deposited(msg.sender, _token, _amount);
    }

    /// @notice Allows a user to withdraw their ERC20 tokens from the contract
    /// @param _token The address of the ERC20 token to withdraw
    /// @param _amount The amount of tokens to withdraw
    function withdraw(address _token, uint256 _amount) external {
        require(_amount > 0, "Amount must be greater than zero");
        require(userBalances[msg.sender][_token] >= _amount, "Insufficient balance");

        IERC20 token = IERC20(_token);

        // Deduct the amount from the user's balance
        userBalances[msg.sender][_token] -= _amount;

        // Transfer tokens back to the user
        require(token.transfer(msg.sender, _amount), "Token transfer failed");

        // Emit the withdrawal event
        emit Withdrawn(msg.sender, _token, _amount);
    }

    /// @notice Returns the token balance of a specific user
    /// @param _user The address of the user whose balance is being queried
    /// @param _token The address of the ERC20 token
    /// @return The balance of the specified token for the user
    function getBalance(address _user, address _token) external view returns (uint256) {
        return userBalances[_user][_token];
    }

    /// @notice Allows the current owner to transfer ownership of the contract
    /// @dev Only the current owner can call this function
    /// @param newOwner The address of the new contract owner
    function changeOwner(address newOwner) external onlyOwner {
        require(newOwner != address(0), "Invalid address");
        owner = newOwner;
    }
}
