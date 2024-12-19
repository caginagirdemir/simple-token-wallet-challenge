// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "../contracts/YourContract.sol";
import {Script} from "forge-std/Script.sol";

contract DeployYourContract is Script {
    function run() external {
        vm.startBroadcast(); 

        YourContract yourContract = new YourContract();


        vm.stopBroadcast();
    }
}
