# Module_20_Smart_Contract
A blockchain-based Solidity smart contract which implements a joint savings account allowing deposit and withdrawal of funds by authorised account holders.


Author: Bruno Ivasic   
Date: 23 January 2024

# Submission  
Files associated with this solution:   
* [Smart Contract Source Code: /Submission/joint_savings.sol](./Submission/Code/joint_savings.sol)
* [Screen shots folder: /Submission/Screenshots](./Submission/Screenshots)


# Output Screen Shots
## 1. Screenshot following `setAccounts` function execution
![alt="1. Screenshot following `setAccounts` function execution"](./Submission/Screenshots/01_SetAccount.png)

---
## 2. Screenshots following `deposit` function execution
### 2.1 `deposit` sending 1 ether as wei
![alt="2.1 `deposit` sending 1 ether as wei"](./Submission/Screenshots/02_Tx_1_Send_1_ether_as_wei.png)
### 2.2 `deposit` sending 10 ether as wei
![alt="2.2 `deposit` sending 10 ether as wei"](./Submission/Screenshots/02_Tx_2%20_Send_10_ether_as_wei.png)
### 2.3 `deposit` sending 5 ether
![alt="2.3 `deposit` sending 5 ether"](./Submission/Screenshots/02_Tx_3_Send_5_ether.png)
---

## 3. Screenshots following `withdraw` execution
These also show the `contractBalance`, `lastToWithdraw` and `lastWithdrawAmount` functions were executed following the `withdraw` to verify that the funds were withdrawn from the contract as can be seen in the `RUN & DEPLOY TRANSACTIONS` panel on the left.

### 3.1 `withdraw` of 5 ether into `accountOne`
![alt="3.1 `withdraw` of 5 ether into `accountOne`"](./Submission/Screenshots/03_Tx_1_Withdraw_5_ether_into_accountOne.png)


### 3.2 `withdraw` of 10 ether into `accountTwo`
![alt="3.2 `withdraw` of 10 ether into `accountTwo`"](./Submission/Screenshots/03_Tx_2_Withdraw_10_ether_into_accountTwo.png)

---
# Scope for Future Enhancements
The following changes / enhancements were considered but not implmented for reasons of needing to remain broadly within the confines of the original starter code and scoring guidelines. Potential future releases could include:
1. Using a Mapping, ideally an [Iterable Mapping](https://github.com/ethereum/dapp-bin/blob/master/library/iterable_mapping.sol) to keep track of account owner addresses, thus allowing the contract to have a larger number of joint account holders without the need to hard code corresponding
individual variables. E.g. `mapping (address => bool) private _accountOwners`  instead of `accountThree`, `accountFour` etc.
2. Calling `setAccounts` from a newly defined `constructor` function to avoid any time lag between when the contract is created and when the 
accounts are set, to avoid potential for hijacking the contract during that interim state.
---

# Technologies
* [Solidity](https://soliditylang.org/) - A statically-typed curly-braces programming language designed for developing smart contracts that run on Ethereum
* [OpenZepplin Safe Math](https://docs.openzeppelin.com/contracts/2.x/api/math) - wrappers over Solidity’s arithmetic operations with added overflow checks which trigger exceptions in the event of arithmetic overflow so as to catch bugs and minimise opportunities for exploits.
* [Remix - Ethereum IDE](https://remix-ide.readthedocs.io/en/latest/) - an Integrated Development Environment (IDE) for smart contract development that includes developer Graphical User Interface (GUI), Solidity compiler, 
* [Ethereum Virtual Machine (EVM)](https://docs.soliditylang.org/en/v0.8.23/introduction-to-smart-contracts.html#the-ethereum-virtual-machine)

# Concepts
* Ethereum Blockchain Transactions
* Smart Contract
* Ethereum Virtual Machine (EVM)


# Enhancements to base starter code
* Items marked as @TODO
* Error Handling and Validation
  * Provisioned Safe Math to intercept arithmetic overflow exploits (although not used as no arithmetic functions were necessary).
* Documentation and Commenting
  * Adopted [Ethereum Natural Language Specification Format \(NatSpec\)](https://docs.soliditylang.org/en/develop/natspec-format.html) for code commenting. 
  * Added in-depth comments in complex sections of the code to enhance the maintainability and scalability of the application code. 

# Dependencies
* OpenZepplin Safe Math

# Installation / Setup
No installation is required if using the web app online version of [Remix Online IDE](https://remix.ethereum.org). 

# Launching
*** TO DO ***


# Briefing
* [Assignment Briefing](./Briefing/README.md)

# Disclaimer
1. The smart contract included in this project is provided as is.
1. No guarantee, representation or warranty is being made, express or implied, as to the safety or correctness of the user interface or of the smart contract itself.
1. This smart contract has not been independently audited and as such there is no assurance that it will work as intended. Users may experience delays, failures, errors, omissions, loss of transmitted information, or financial loss.
1. No warranty of merchantability, non-infringement or fitness for any particular purpose is made.
1. Use of this smart contract may be restricted or prohibited under applicable law, including securities laws.
1. Advice from competent legal counsel is strongly recommended before considering use of this smart contract.
1. Information provided in this repository shall not be construed as investment advice or legal advice, and is not meant to replace competent legal counsel.
