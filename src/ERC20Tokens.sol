// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.26;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/utils/Pausable.sol";
import "./ERC20TokensAccessControl.sol";

/// @title ERC20Tokens Contract
/// @notice An ERC20 token contract with additional features such as locking balances, access control, and pausable functionality.
contract ERC20Tokens is ERC20, Pausable, ERC20TokensAccessControl {
    // Custom errors
    error UnauthorizedRecipient(address to);

    /// @dev Constructor that initializes the ERC20Tokens contract and mints initial supply to deployer.
    /// @param name The name of the token.
    /// @param symbol The symbol of the token.
    /// @param initialSupply The initial supply to mint to the deployer (in smallest units, e.g., cents).
    constructor(string memory name, string memory symbol, uint256 initialSupply)
        ERC20(name, symbol)
        ERC20TokensAccessControl()
    {
        _mint(msg.sender, initialSupply);
        enableAccount(msg.sender);
    }

    /// @dev Retrieves the number of decimal places for the token.
    /// @return The number of decimal places as a uint8.
    function decimals() public pure override returns (uint8) {
        return 2; // Modify this value according to the decimal places needed for your token
    }

    /// @dev Contract pause in case of emergency
    function pause() external onlyRole(PAUSER_ROLE) {
        _pause();
    }

    /// @dev Contract unpause
    function unpause() external onlyRole(PAUSER_ROLE) {
        _unpause();
    }

    /// @dev Mints new tokens and adds them to the specified address.
    /// @param to The address to mint tokens.
    /// @param amount The amount of tokens to mint.
    function mint(address to, uint256 amount) external whenNotPaused onlyRole(MINTER_ROLE) {
        if (!verifyAccount(to)) {
            revert UnauthorizedRecipient(to);
        }
        _mint(to, amount);
    }

    /// @dev Burns tokens from a specified address.
    /// @param from The address to burn tokens from.
    /// @param amount The amount of tokens to burn.
    function burn(address from, uint256 amount) external whenNotPaused onlyRole(BURNER_ROLE) {
        _burn(from, amount);
    }

    /// @dev Transfers tokens to one address.
    /// @param to The address to transfer tokens to.
    /// @param amount The amount of tokens to transfer.
    function transfer(address to, uint256 amount)
        public
        override
        whenNotPaused
        checkAccess(msg.sender, to)
        returns (bool)
    {
        super.transfer(to, amount);
        return true;
    }

    /// @dev Transfers tokens from one address to another.
    /// @param from The address to transfer tokens from.
    /// @param to The address to transfer tokens to.
    /// @param amount The amount of tokens to transfer.
    function transferFrom(address from, address to, uint256 amount)
        public
        override
        whenNotPaused
        checkAccess(from, to)
        onlyRole(TRANSFER_ROLE)
        returns (bool)
    {
        super.transferFrom(from, to, amount);
        return true;
    }

    /// @dev Checks if an address is an authorized account.
    /// @param account The address to check.
    /// @return A boolean indicating if the address is an authorized account.
    function isAuthorizedAccount(address account) external view returns (bool) {
        return verifyAccount(account);
    }
}
