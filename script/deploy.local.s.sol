// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.26;

import { Script, console2 } from "forge-std/Script.sol";
import { ZKVerifyToken } from "../src/ZKVerifyToken.sol";

contract Local is Script {
    ZKVerifyToken public _token;

    function setUp() public { }

    function run() public {
        vm.startBroadcast(0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80);

        _token = new ZKVerifyToken();
        console2.log("ZKVerifyToken(ZKV) address: ", address(_token));

        vm.stopBroadcast();
    }
}
