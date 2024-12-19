// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../contracts/YourContract.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

// Mock ERC20 Token
contract MockERC20 is ERC20 {
    constructor() ERC20("MockToken", "MTK") {
        _mint(msg.sender, 1000 * 10**18);
    }
}

contract YourContractTest is Test {
    YourContract yourContract;
    MockERC20 token;

    address owner;
    address user1;

    function setUp() public {
        console.log(string(abi.encodePacked(unicode"🔧 Setting up the test environment...")));
        owner = address(this);
        user1 = address(0x123);
        console.log(string(abi.encodePacked(unicode"🚀 Deploying YourContract and MockERC20...")));
        yourContract = new YourContract();
        token = new MockERC20();
        console.log(string(abi.encodePacked(unicode"💸 Transferring 100 MTK to user1...")));
        token.transfer(user1, 100 * 10**18);
        console.log(string(abi.encodePacked(unicode"✅ Setup completed.")));
    }

    /// @notice Deposit Functionality
    function testDeposit() public {
        console.log(string(abi.encodePacked(unicode"🔎 Running testDeposit...")));
        vm.startPrank(user1);
        token.approve(address(yourContract), 50 * 10**18);
        yourContract.deposit(address(token), 50 * 10**18);
        uint256 balance = yourContract.getBalance(user1, address(token));
        assertEq(balance, 50 * 10**18, "User1 balance should be 50 MTK");
        console.log(string(abi.encodePacked(unicode"✅ testDeposit completed successfully.")));
        vm.stopPrank();
    }

    /// @notice Withdraw Functionality
    function testWithdraw() public {
        console.log(string(abi.encodePacked(unicode"🔎 Running testWithdraw...")));
        vm.startPrank(user1);
        token.approve(address(yourContract), 50 * 10**18);
        yourContract.deposit(address(token), 50 * 10**18);
        uint256 balanceBefore = yourContract.getBalance(user1, address(token));
        yourContract.withdraw(address(token), 30 * 10**18);
        uint256 balanceAfter = yourContract.getBalance(user1, address(token));
        assertEq(balanceBefore, 50 * 10**18, "Balance before withdraw should be 50 MTK");
        assertEq(balanceAfter, 20 * 10**18, "Balance after withdrawing 30 MTK should be 20 MTK");
        console.log(string(abi.encodePacked(unicode"✅ testWithdraw completed successfully.")));
        vm.stopPrank();
    }

    /// @notice getBalance Functionality
    function testGetBalance() public {
        console.log(string(abi.encodePacked(unicode"🔎 Running testGetBalance...")));
        vm.startPrank(user1);
        token.approve(address(yourContract), 50 * 10**18);
        yourContract.deposit(address(token), 50 * 10**18);
        uint256 balance = yourContract.getBalance(user1, address(token));
        assertEq(balance, 50 * 10**18, "User1's balance should be 50 MTK");
        console.log(string(abi.encodePacked(unicode"✅ testGetBalance completed successfully.")));
        vm.stopPrank();
    }

    /// @notice Withdraw More Than Balance
    function testWithdrawMoreThanBalance() public {
        console.log(string(abi.encodePacked(unicode"🔎 Running testWithdrawMoreThanBalance...")));
        vm.startPrank(user1);
        token.approve(address(yourContract), 50 * 10**18);
        yourContract.deposit(address(token), 50 * 10**18);
        vm.expectRevert("Insufficient balance");
        yourContract.withdraw(address(token), 60 * 10**18);
        console.log(string(abi.encodePacked(unicode"✅ testWithdrawMoreThanBalance reverted as expected.")));
        vm.stopPrank();
    }

    function testDepositZeroAmount() public {
        console.log(string(abi.encodePacked(unicode"🔎 Running testDepositZeroAmount...")));
        vm.startPrank(user1);
        token.approve(address(yourContract), 0);
        vm.expectRevert("Amount must be greater than zero");
        yourContract.deposit(address(token), 0);
        console.log(string(abi.encodePacked(unicode"✅ testDepositZeroAmount reverted as expected.")));
        vm.stopPrank();
    }
}
