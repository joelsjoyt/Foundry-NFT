// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {MoodNFT} from "../src/MoodNFT.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract DeployMoodNFT is Script {
    MoodNFT public moodNFT;

    function run() public returns (MoodNFT) {
        string memory happySVG = vm.readFile("./img/happy.svg");
        string memory sadSVG = vm.readFile("./img/sad.svg");

        vm.startBroadcast();
        moodNFT = new MoodNFT(svgToImageURI(happySVG), svgToImageURI(sadSVG));
        vm.stopBroadcast();

        return moodNFT;
    }

    function svgToImageURI(
        string memory svg
    ) public pure returns (string memory) {
        string memory baseURL = "data:image/svg+xml;base64,";
        string memory svgBase64Encoded = Base64.encode(
            bytes(string(abi.encodePacked(svg)))
        );

        return string(abi.encodePacked(baseURL, svgBase64Encoded));
    }
}
