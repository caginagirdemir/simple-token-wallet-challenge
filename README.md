Here is the `README.md` content in markdown format:

---

# MonadWalletToken

## Overview

`MonadWalletToken` is a Solidity smart contract that combines an **ERC20 token** implementation with a **simple token wallet**. Users can:
1. Deposit and withdraw **MON tokens** (or other ERC20 tokens).
2. View their token balances.
3. Use the `MON` token for various purposes.

The contract also includes functionality to **mint tokens** and **manage ownership**.

---

## Features

1. **Token Deployment**  
   The contract mints `1,000,000 MON` tokens to the contract creator during deployment.

2. **Token Deposit**  
   Users can deposit `MON` or other ERC20 tokens into the smart contract.

3. **Token Withdrawal**  
   Users can withdraw their deposited tokens at any time, provided they have sufficient balance.

4. **View Token Balance**  
   Users can view their token balances via the `getBalance` function.

5. **Owner Management**  
   The contract owner can transfer ownership to another address.

---

## Functions

### 1. Token Deposit
- Allows users to deposit `MON` or other ERC20 tokens into the smart contract.
- Tokens are transferred from the user to the contract's address.

```solidity
function deposit(address _token, uint256 _amount) external
```

### 2. Token Withdrawal
- Allows users to withdraw tokens they have deposited into the contract.

```solidity
function withdraw(address _token, uint256 _amount) external
```

### 3. View Balance
- Returns the balance of a specific user for a given token.

```solidity
function getBalance(address _user, address _token) external view returns (uint256)
```

### 4. Change Owner
- Enables the contract owner to transfer ownership to a new address.

```solidity
function changeOwner(address newOwner) external onlyOwner
```

---

## Example Deployment

1. **Deploy the Contract**  
   Upon deployment, the contract mints `1,000,000 MON` tokens to the deployer's address.

2. **Deposit Tokens**  
   Users can call the `deposit` function to deposit `MON` or any ERC20 token into the contract.

3. **Withdraw Tokens**  
   Users can call the `withdraw` function to withdraw their tokens.

4. **Check Balances**  
   Use `getBalance` to view token balances for a specific user.

---

## Events

| Event         | Description                                        |
|---------------|----------------------------------------------------|
| **Deposited** | Triggered when a user deposits tokens.             |
| **Withdrawn** | Triggered when a user withdraws tokens.            |
| **OwnerChanged** | Triggered when the ownership of the contract changes. |

---

## License

This project is licensed under the [MIT License](https://opensource.org/licenses/MIT).

---