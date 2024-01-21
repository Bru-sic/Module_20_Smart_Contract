// SPDX-License-Identifier: MIT

pragma solidity ^0.5.0;

/** @notice
Joint Savings Account
=====================
A blockchain-based Solidity smart contract which implements a joint savings account for a financial institution allowing deposit and
withdrawal of funds by authorised account holders.

To automate the creation of joint savings accounts, the solidity smart contract accepts two user addresses that are then able to control
action on the joint savings account. The smart contract uses ether management functions to implement various requirements to provide the
features of the joint savings account.
*/ 

/** @notice
Development Environment
-----------------------
IDE: Remix Online IDE, see: https://remix.ethereum.org
Solidity Compiler Settings:
 * Compiler: 0.5.0+commit.1d4f565a;
 * Auto compile: On;
 * Language: Solidity;
 * EVM Version: byzantium;
 * Enable optimization: Off;
*/ 

/** @notice
Import Dependencies
-------------------
    The SafeMath library has been integrated to catch any underflows or overflows when performing math operations on unsigned integers.
    Althought the default behaviour of Solidity 0.8.0 and above for overflow / underflow is to throw an error, this contract implements
    the SafeMath library for backwards compatibility since the contract is built on Solidity version 0.5.0.
*/ 
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/math/SafeMath.sol";


/// @title implements a joint savings account allowing deposit and withdrawal of funds by authorised account holders
/// @author Bruno Ivasic
contract JointSavings {
    /// @dev Add methods from the SafeMath library to this contract to implement arithmetic underflow and overflow exception handling.
    using SafeMath for uint;   // Add methods from the SafeMath library for unsigned integers (uint)

    /// @dev Contract Variable Definitions
    address payable accountOne;          /// @dev Address of the first account holder
    address payable accountTwo;          // Address of the second account holder
    
    address public  lastToWithdraw;      // Address of the last addressed used to make   
    uint    public  lastWithdrawAmount;  // Amount last withdrawn

    uint    public  contractBalance;     // Current balance of the contract (account)

    // Define the contract's Methods...

    /** @notice 
    Contract Method: withdraw
    Purpose: Withdraw the specified amount of funds from the joint account contract to the recipient  
    Contraints:
       * Recipient's address must be one of the account holders.
       * Requested withdrawal amount must be less than or equal to the current balance.
    Tasks:
       * Throw exception if recipient is not one of the account holders
       * Throw exception if sender of message if is not one of the account holders (additional edge case)
       * Throw an execption if the amount requested to be withdrawn is equal to zero
       * Throw exception if the amount requested to be withdrawn is greater than the current balance
       * Updates lastToWithdraw with the address of the recipient, only if different
       * Transfers the requested amount to the recipient's address
       * Updates the lastWithdrawAmount with the amount withdrawn
       * Updates the local current balance to the contract's current balance 
    */
    /// @param amountInWei The value in Wei to withdraw from the contract (account).
    /// @param recipient The address of the recipient where the funds will be transfered to.
    function withdraw(uint amountInWei, address payable recipient) public {
        /// @dev Do initial validation to ensure the request is valid

        /// @dev Throw an exception if the accountOne owner has not been set using `setAccounts`
        require(accountOne != address(0), "Set the first account owner using 'setAccounts'!");

        /// @dev Throw an exception if the accountTwo owner has not been set using `setAccounts`
        require(accountTwo != address(0), "Set the second account owner using 'setAccounts'!");

        /// @dev Throw an exception if the message sender is not one of the account holders
        require((msg.sender == accountOne) || (msg.sender == accountTwo) , "You don't own this account (`sender` is not an account owner)!");

        /// @dev Throw an exception if withdrawing to an address not registered as one of the account holders
        require((recipient == accountOne) || (recipient == accountTwo) , "You don't own this account (`recipient` is not an account owner)!");

        /// @dev Throw an execption if the `amountInWei' requested to be withdrawn is equal to zero
        require(amountInWei>0,"Withdrawal amount must be greater than 0!");

        /// @dev Throw an execption if the `amountInWei' requested to be withdrawn is greater than the current balance
        require(amountInWei<=contractBalance,"Insufficient funds!");

        /// @dev All validation passed, now its time to update some information.

        /// @dev Set who made the last withdrawal by setting the `lastToWithdraw` address with the value of the `recipient`
        /// @dev To minimise gas expense, only update the lastToWithdraw if it changes
        if (lastToWithdraw != recipient) {
            lastToWithdraw = recipient;
        }
        
        /// @dev Transfer the `amountInWei` in Wei from the smart contract to the `recipient`'s address
        recipient.transfer(amountInWei);

        /// @dev Set the `lastWithdrawAmount` equal to `amountInWei`
        lastWithdrawAmount = amountInWei;

        /// @dev Set `contractBalance` to match the actual contract balalance to account for any gas expenses
        contractBalance = address(this).balance;
    }

    /** @notice 
    Contract Method: deposit
    Purpose: Deposits funds into the joint account contract  
    Contraints: None - anyone can deposit into the account.
    Tasks:
       * Updates the local current balance to the contract's current balance 
    */
    function deposit() public payable {
        /// @dev Set `contractBalance` to match the actual contract balalance to account for any gas expenses
        contractBalance = address(this).balance;
    }

    /** @notice 
    Contract Method: setAccounts
    Purpose: Sets the account addresses of the joint account holders  
    Contraints:
       * The new account holder's address must not be 0x0 which is a special address representing a burned or uninitialised address.
       * The accounts must not have already been set
       * The sender of the message must be one of the accounts specified.
    Tasks:
       * Throw exception if account holder addresses have already been set
       * Throw exception if either new addresses are invalid
       * Throw exception if both new addresses are the same
       * Throw exception if sender of message if is not one of the account holders
       * Updates the details of the account owners with those specified 
    */
    /// @param account1 The address of the first account holder of the smart contract account.
    /// @param account2 The address of the second account holder of the smart contract account.
    function setAccounts(address payable account1, address payable account2) public{
        /// @dev Do initial validation to ensure the request is valid
        
        /// @dev Throw an exception if the account owners (`accountOne` and `accountTwo`) have already been set
        /// @dev This is to prevent unauthorised changing of account owners even if it is done by one of the existing ones
        require(accountOne == address(0) && accountTwo == address(0),"Account owners have already been set!" );

        /// @dev Throw an exception if account1 is not a valid address
        require(account1 != address(0), "Invalid address specified for `account1`!");

        /// @dev Throw an exception if account2 is not a valid address
        require(account2 != address(0), "Invalid address specified for `account2`!");

        /// @dev Throw an exception if account1 equals account2 - as it would not be a joint account
        require(account1 != account2, "`account1` address must be different to `account2` address!");

        /// @dev Throw an exception if the message sender is not one of the new account holders
        require((msg.sender == account1) || (msg.sender == account2) , "Sender must be either `account1` or `account2`");

        /// @dev Store the values of `accountOne` and `accountTwo` to `account1` and `account2` respectively.
        accountOne = account1; /// @dev Set the new first account owner
        accountTwo = account2; /// @dev Set the new second account owner
    }

    /** @notice 
    Contract Method: default fallback function
    Purpose: If neither a receive Ether nor a payable fallback function is present, the contract cannot
             receive Ether through a transaction that does not represent a payable function call and
             throws an exception. To avoid the exception, this default fallback funtion is defined
             so that the contract can store Ether sent from outside the deposit function.    
    */
    function() external payable {
    }

    /** @notice
    DISCLAIMER
    ==========
    1. The smart contract included in this project is provided as is.
    2. No guarantee, representation or warranty is being made, express or implied, as to the safety or correctness of the
       user interface or of the smart contract itself.
    3. This smart contract has not been independently audited and as such there is no assurance that it will work as intended.
       Users may experience delays, failures, errors, omissions, loss of transmitted information, or financial loss.
    4. No warranty of merchantability, non-infringement or fitness for any particular purpose is made.
    5. Use of this smart contract may be restricted or prohibited under applicable law, including securities laws.
    6. Advice from competent legal counsel is strongly recommended before considering use of this smart contract.
    7. Information provided in this repository shall not be construed as investment advice or legal advice, and is not meant
       to replace competent legal counsel.
    */
}
