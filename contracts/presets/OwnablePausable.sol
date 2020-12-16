// SPDX-License-Identifier: AGPL-3.0-only

pragma solidity 0.7.5;

import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/utils/Pausable.sol";
import "../interfaces/IOwnablePausable.sol";

/**
 * @title OwnablePausable
 *
 * @dev Bundles Access Control and Pausable contracts in one.
 *
 */
abstract contract OwnablePausable is IOwnablePausable, Pausable, AccessControl {
    bytes32 public constant PAUSER_ROLE = keccak256("PAUSER_ROLE");

    /**
    * @dev Modifier for checking whether the caller is an admin.
    */
    modifier onlyAdmin() {
        require(hasRole(DEFAULT_ADMIN_ROLE, msg.sender), "OwnablePausable: permission denied");
        _;
    }

    /**
    * @dev Modifier for checking whether the caller is a pauser.
    */
    modifier onlyPauser() {
        require(hasRole(PAUSER_ROLE, msg.sender), "OwnablePausable: permission denied");
        _;
    }

    /**
     * @dev Grants `DEFAULT_ADMIN_ROLE`, `PAUSER_ROLE` to the admin account.
     */
    constructor(address _admin) internal {
        _setupRole(DEFAULT_ADMIN_ROLE, _admin);
        _setupRole(PAUSER_ROLE, _admin);
    }

    /**
     * @dev See {IOwnablePausable-isPauser}.
     */
    function isPauser(address _account) public override view returns (bool) {
        return hasRole(PAUSER_ROLE, _account);
    }

    /**
     * @dev See {IOwnablePausable-addPauser}.
     */
    function addPauser(address _account) external override {
        grantRole(PAUSER_ROLE, _account);
    }

    /**
     * @dev See {IOwnablePausable-removePauser}.
     */
    function removePauser(address _account) external override {
        revokeRole(PAUSER_ROLE, _account);
    }

    /**
     * @dev See {IOwnablePausable-pause}.
     */
    function pause() external override onlyPauser {
        _pause();
    }

    /**
     * @dev See {IOwnablePausable-unpause}.
     */
    function unpause() external override onlyPauser {
        _unpause();
    }
}