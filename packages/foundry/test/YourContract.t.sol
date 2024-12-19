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

    function testDeposit() public {
        console.log(string(abi.encodePacked(unicode"🔎 Running testDeposit...")));

        console.log(string(abi.encodePacked(unicode"👤 Starting prank as user1...")));
        vm.startPrank(user1);

        console.log(string(abi.encodePacked(unicode"🔐 Approving YourContract to spend 50 MTK...")));
        token.approve(address(yourContract), 50 * 10**18);

        console.log(string(abi.encodePacked(unicode"💾 Depositing 50 MTK to YourContract...")));
        yourContract.deposit(address(token), 50 * 10**18);

        uint256 balance = yourContract.getBalance(user1, address(token));
        console.log(string(abi.encodePacked(unicode"📊 Checking balance in YourContract...")));
        console.log("User1's balance in YourContract:", balance);

        assertEq(balance, 50 * 10**18, "User1 balance should be 50 MTK");

        console.log(string(abi.encodePacked(unicode"✅ testDeposit completed successfully.")));
        vm.stopPrank();
    }
}
