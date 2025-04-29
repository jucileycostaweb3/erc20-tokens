// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.26;

import "./ERC20Tokens.sol";

contract ZKVerifyToken is ERC20Tokens {
    constructor() ERC20Tokens("ZKV Token", "ZKV", 20000000) { }
}
