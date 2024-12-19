//SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "forge-std/console.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";



contract YourContract {
  address public owner;

    
    mapping(address => mapping(address => uint256)) public userBalances;

  
    event Deposited(address indexed user, address indexed token, uint256 amount);
    event Withdrawn(address indexed user, address indexed token, uint256 amount);

  
    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function deposit(address _token, uint256 _amount) external {
        require(_amount > 0, "Amount must be greater than zero");
        IERC20 token = IERC20(_token);
        require(token.transferFrom(msg.sender, address(this), _amount), "Token transfer failed");
        userBalances[msg.sender][_token] += _amount;
        emit Deposited(msg.sender, _token, _amount);
    }


    function withdraw(address _token, uint256 _amount) external {
        require(_amount > 0, "Amount must be greater than zero");
        require(userBalances[msg.sender][_token] >= _amount, "Insufficient balance");
        IERC20 token = IERC20(_token);
        userBalances[msg.sender][_token] -= _amount;
        require(token.transfer(msg.sender, _amount), "Token transfer failed");
        emit Withdrawn(msg.sender, _token, _amount);
    }

    function getBalance(address _user, address _token) external view returns (uint256) {
        return userBalances[_user][_token];
    }

    function changeOwner(address newOwner) external onlyOwner {
        require(newOwner != address(0), "Invalid address");
        owner = newOwner;
    }
}