// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.26;

import { Script, console2 } from "forge-std/Script.sol";
import { ZKVerifyToken } from "../src/ZKVerifyToken.sol";

contract LocalScript is Script {
    function run() external returns (ZKVerifyToken) {
        vm.startBroadcast();

        ZKVerifyToken _token = new ZKVerifyToken();

        vm.stopBroadcast();
        return _token;
    }
}
