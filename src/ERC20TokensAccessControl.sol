// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.26;

import "@openzeppelin/contracts/access/AccessControl.sol";

/// @title ERC20TokensAccessControl Contract
/// @notice A contract that manages access control for the tokens.
abstract contract ERC20TokensAccessControl is AccessControl {
    // Roles for different access control functions
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    bytes32 public constant TRANSFER_ROLE = keccak256("TRANSFER_ROLE");
    bytes32 public constant BURNER_ROLE = keccak256("BURNER_ROLE");
    bytes32 public constant PAUSER_ROLE = keccak256("PAUSER_ROLE");

    // Mapping to store authorized accounts
    mapping(address => bool) public authorizedAccounts;

    // Custom errors
    error AccountsNotAuthorized(address from, address to);
    error AccountAlreadyEnabled(address account);
    error AccountAlreadyDisabled(address account);

    // Event emitted when an account is enabled
    event EnabledAccount(address member);

    // Event emitted when an account is disabled
    event DisabledAccount(address member);

    /// @dev Contract constructor.
    constructor() {
        // Set the contract admin role
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);

        // Set up the various roles with the admin address
        _grantRole(MINTER_ROLE, msg.sender);
        _grantRole(TRANSFER_ROLE, msg.sender);
        _grantRole(BURNER_ROLE, msg.sender);
        _grantRole(PAUSER_ROLE, msg.sender);
    }

    /// @dev Modifier to check if both 'from' and 'to' addresses are authorized.
    /// @param from The address of the sender.
    /// @param to The address of the receiver.
    modifier checkAccess(address from, address to) {
        if (!authorizedAccounts[from] || !authorizedAccounts[to]) {
            revert AccountsNotAuthorized(from, to);
        }
        _;
    }

    /// @dev Enables an account to have access.
    /// @param member The address of the account to enable.
    function enableAccount(address member) public onlyRole(DEFAULT_ADMIN_ROLE) {
        if (authorizedAccounts[member]) {
            revert AccountAlreadyEnabled(member);
        }
        authorizedAccounts[member] = true;
        emit EnabledAccount(member);
    }

    /// @dev Disables an account from having access.
    /// @param member The address of the account to disable.
    function disableAccount(address member) public onlyRole(DEFAULT_ADMIN_ROLE) {
        if (!authorizedAccounts[member]) {
            revert AccountAlreadyDisabled(member);
        }
        authorizedAccounts[member] = false;
        emit DisabledAccount(member);
    }

    /// @dev Verifies if an account is authorized.
    /// @param account The address of the account to verify.
    /// @return A boolean indicating if the account is authorized.
    function verifyAccount(address account) public view returns (bool) {
        return authorizedAccounts[account];
    }
}
