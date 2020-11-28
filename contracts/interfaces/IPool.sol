// SPDX-License-Identifier: AGPL-3.0-only

pragma solidity 0.7.5;
pragma abicoder v2;

import "./IValidatorRegistration.sol";

/**
 * @dev Interface of the Pool contract.
 */
interface IPool {
    /**
    * @dev Structure for passing information about new Validator.
    * @param publicKey - BLS public key of the validator, generated by the operator.
    * @param signature - BLS signature of the validator, generated by the operator.
    * @param depositDataRoot - hash tree root of the deposit data, generated by the operator.
    */
    struct Validator {
        bytes publicKey;
        bytes signature;
        bytes32 depositDataRoot;
    }

    /**
    * @dev Constructor for initializing the Pool contract.
    * @param _stakedEthToken - address of the StakedEthToken contract.
    * @param _settings - address of the Settings contract.
    * @param _operators - address of the Operators contract.
    * @param _validatorRegistration - address of the VRC (deployed by Ethereum).
    * @param _validators - address of the Validators contract.
    */
    function initialize(
        address _stakedEthToken,
        address _settings,
        address _operators,
        address _validatorRegistration,
        address _validators
    ) external;

    /**
    * @dev Function for retrieving the total collected amount.
    */
    function collectedAmount() external view returns (uint256);

    /**
    * @dev Function for retrieving the validator registration contract address.
    */
    function validatorRegistration() external view returns (IValidatorRegistration);

    /**
    * @dev Function for adding deposits to the pool.
    * The depositing will be disallowed in case `Pool` contract is paused in `Settings` contract.
    */
    function addDeposit() external payable;

    /**
    * @dev Function for registering new pool validator.
    * @param _validator - validator to register.
    */
    function registerValidator(Validator calldata _validator) external;
}
