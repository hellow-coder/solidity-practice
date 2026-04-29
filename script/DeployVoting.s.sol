// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script, console} from "forge-std/Script.sol";
import {Voting} from "../src/Voting.sol";

contract DeployVoting is Script {
    function run() external {

        // vm.envUint HATAO ❌
        // Seedha startBroadcast() likho ✅
        vm.startBroadcast();

        string[] memory candidateNames = new string[](3);
        candidateNames[0] = "Alice";
        candidateNames[1] = "Bob";
        candidateNames[2] = "Charlie";

        Voting voting = new Voting(candidateNames);

        vm.stopBroadcast();

        console.log("Voting Contract:", address(voting));
    }
}