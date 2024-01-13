// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
import {BasicNFT} from "../src/BasicNft.sol";
import {MoodNFT} from "../src/MoodNFT.sol";

contract MintBasicNFT is Script {
    string public constant URI =
        "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";

    function run() external {
        address mostRecentDeployment = DevOpsTools.get_most_recent_deployment(
            "BasicNFT",
            block.chainid
        );
        mintNFTOnContract(mostRecentDeployment);
    }

    function mintNFTOnContract(address _nftContractAddress) public {
        vm.startBroadcast();
        BasicNFT(_nftContractAddress).mintNFT("Doggie");
        vm.stopBroadcast();
    }
}

contract MintMoodNFT is Script {
    function run() external {
        address mostRecentDeployment = DevOpsTools.get_most_recent_deployment(
            "MoodNFT",
            block.chainid
        );
        mintMoodNFT(mostRecentDeployment);
    }

    function mintMoodNFT(address _nftContractAddress) public {
        vm.startBroadcast();
        MoodNFT(_nftContractAddress).mintNFT();
        vm.stopBroadcast();
    }
}

contract FlipMoodNFT is Script {
    uint256 public constant TOKEN_ID_TO_FLIP = 0;

    function run() external {
        address mostRecentDeployment = DevOpsTools.get_most_recent_deployment(
            "MoodNFT",
            block.chainid
        );
        flipMoodNFT(mostRecentDeployment);
    }

    function flipMoodNFT(address _nftContractAddress) public {
        vm.startBroadcast();
        MoodNFT(_nftContractAddress).flipMood(TOKEN_ID_TO_FLIP);
        vm.stopBroadcast();
    }
}
