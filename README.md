# **Monad Solidity Challenge #1 Submission**
---
![img1](ss1.png)
![img2](ss2.png)
## **Overview of the Contracts**

### 1. **YourContract.sol**
- **Purpose**: A simple wallet contract that allows users to deposit, withdraw, and check their ERC20 token balances.
- **Features**:
  - **Deposit**: Users can deposit any ERC20 tokens into the wallet.
  - **Withdraw**: Users can withdraw their tokens if they have sufficient balance.
  - **Balance Check**: Allows users to view their wallet balances for specific tokens.
  - **Owner Management**: The contract includes ownership management functionality.

---

### 2. **MonadToken.sol**
- **Purpose**: A standard ERC20 token contract for the token **"Monad Token"** (symbol: `MON`).
- **Features**:
  - Total supply of `1,000,000 MON` tokens minted to the deployer during deployment.
  - Standard ERC20 functionalities (transfer, approve, etc.).

---

## **Testing the Project**

```bash
yarn chain
yarn deploy
yarn start
```


This project uses **Foundry** for testing. The test suite verifies key functionalities like token deposit, balance checks, and token approval.

### **Test File: YourContract.t.sol**
Located in `test/YourContract.t.sol`.

#### Key Test Case: `testDeposit`
- **Purpose**: Tests the deposit functionality of the `YourContract`.
- **Steps**:
  1. Deploy `YourContract` and a mock ERC20 token (`MockERC20`).
  2. Transfer tokens to a test user (`user1`).
  3. Approve the wallet contract to spend tokens on behalf of the user.
  4. Deposit tokens into the wallet contract.
  5. Verify the user’s token balance in the wallet.


---

## **Example Output**

When the tests run successfully, you should see output like:

```
Ran 5 tests for test/YourContract.t.sol:YourContractTest
[PASS] testDeposit() (gas: 82573)
Logs:
  🔧 Setting up the test environment...
  🚀 Deploying YourContract and MockERC20...
  💸 Transferring 100 MTK to user1...
  ✅ Setup completed.
  🔎 Running testDeposit...
  ✅ testDeposit completed successfully.

[PASS] testDepositZeroAmount() (gas: 25335)
Logs:
  🔧 Setting up the test environment...
  🚀 Deploying YourContract and MockERC20...
  💸 Transferring 100 MTK to user1...
  ✅ Setup completed.
  🔎 Running testDepositZeroAmount...
  ✅ testDepositZeroAmount reverted as expected.

[PASS] testGetBalance() (gas: 82551)
Logs:
  🔧 Setting up the test environment...
  🚀 Deploying YourContract and MockERC20...
  💸 Transferring 100 MTK to user1...
  ✅ Setup completed.
  🔎 Running testGetBalance...
  ✅ testGetBalance completed successfully.

[PASS] testWithdraw() (gas: 92122)
Logs:
  🔧 Setting up the test environment...
  🚀 Deploying YourContract and MockERC20...
  💸 Transferring 100 MTK to user1...
  ✅ Setup completed.
  🔎 Running testWithdraw...
  ✅ testWithdraw completed successfully.

[PASS] testWithdrawMoreThanBalance() (gas: 82260)
Logs:
  🔧 Setting up the test environment...
  🚀 Deploying YourContract and MockERC20...
  💸 Transferring 100 MTK to user1...
  ✅ Setup completed.
  🔎 Running testWithdrawMoreThanBalance...
  ✅ testWithdrawMoreThanBalance reverted as expected.

Suite result: ok. 5 passed; 0 failed; 0 skipped; finished in 1.41ms (1.39ms CPU time)

Ran 1 test suite in 12.81ms (1.41ms CPU time): 5 tests passed, 0 failed, 0 skipped (5 total tests)
```

---

## **License**

This project is licensed under the [MIT License](https://opensource.org/licenses/MIT).

---

## **Contributors**
- **Çağın Ağırdemir**  
Feel free to fork, contribute, and open pull requests!

---

## **Acknowledgments**
This project was forked and inspired by **ScaffoldETH2** and built using the **Foundry** development environment.

