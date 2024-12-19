// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../contracts/MonadToken.sol";
import {Script} from "forge-std/Script.sol";

contract DeployMonadToken is Script {
    function run() external {
        vm.startBroadcast();

        MonadToken monadToken = new MonadToken();
        address recipient = 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266;
        uint256 transferAmount = 100 * 10**18;
        monadToken.transfer(recipient, transferAmount);
        vm.stopBroadcast();
    }
}
