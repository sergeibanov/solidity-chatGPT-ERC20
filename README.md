## ERC-20 Contract Overview

This particular repo is the result of the third task assigned by Chat GPT. I provided the whole idea of the "Solidity Chat GPT Test Tasks Project" [in this repo](https://github.com/sergeibanov/solidity-chatGPT-task-contract). Feel free to read it. Below is the task description provided by Chat GPT:

## Task Description

**Title**: Development of a Smart Contract for Creating and Managing a Simple ERC-20 Token

**Objective**: Craft a Solidity smart contract that implements the standard ERC-20 interface with basic token management functions, ensuring compliance with the ERC-20 standard and secure, correct function implementations.

**Requirements**:

- **Data Structure**:
  - `Token Name`
  - `Token Symbol`
  - `Total supply of tokens`

- **Functions**:
  - `balanceOf(address account)` - Returns the balance of the specified address.
  - `transfer(address recipient, uint256 amount)` - Transfers the specified amount of tokens to the recipient's address.
  - `approve(address spender, uint256 amount)` - Sets allowance for withdrawing the specified amount of tokens.
  - `transferFrom(address sender, address recipient, uint256 amount)` - Transfers tokens from one address to another, assuming that allowance has already been set.
  - `allowance(address owner, address spender)` - Returns the amount of tokens that can be withdrawn from the specified address.

- **Events**:
  - `Transfer(address indexed from, address indexed to, uint256 value)` - Should be generated upon tokens transfer.
  - `Approval(address indexed owner, address indexed spender, uint256 value)` - Should be generated upon setting withdrawal allowance.

- **Additional Requirements**:
  - Initialize the contract creator's initial balance upon deployment.
  - Ensure that all functions securely handle errors and verify the validity of operations (e.g., insufficient balance or overflow).

**Evaluation Criteria**:
- Compliance with the ERC-20 standard.
- Security and correctness of functions.
- Cleanliness and readability of code.
- Correct initialization and data management in the contract.
