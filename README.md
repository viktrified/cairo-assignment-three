# HelloStarknet Cairo Smart Contract

## Overview

This repository contains a simple Cairo smart contract for managing a points-based system on StarkNet. The contract enables users to:

- Add points to their account.
- Redeem points from their account.
- Retrieve the current balance of points in their account.

The contract is implemented using the StarkNet framework and includes events for tracking points addition and redemption.

---

## Features

1. **Add Points**

   - Users can add points to their account using the `add_points` method.
   - Emits an `AddPoint` event upon successful addition.

2. **Redeem Points**

   - Users can redeem points from their account using the `Redeem_point` method.
   - Ensures sufficient points are available before redemption.
   - Emits a `RedeemPoint` event upon successful redemption.

3. **Get Points Balance**
   - Users can retrieve their current points balance using the `get_points` method.

---

## Contract Structure

### Interfaces

- **IHelloStarknet**: Defines the main functions of the points management system:
  - `add_points`
  - `Redeem_point`
  - `get_points`

### Storage

- `balance`: A global balance variable (not currently utilized in methods).
- `userPoints`: A mapping of user addresses to their respective point balances.

### Events

- **AddPoint**: Tracks when points are added to a user account.
- **RedeemPoint**: Tracks when points are redeemed from a user account.

---

## Usage

### Deployment

1. Compile the contract using the StarkNet Cairo compiler.
2. Deploy the compiled contract to the StarkNet blockchain.

### Interacting with the Contract

Use the following methods to interact with the contract:

#### Add Points

```json
{"method": "add_points", "params": {"points": <points_to_add>}}
```

#### Redeem Points

```json
{"method": "Redeem_point", "params": {"amount": <amount_to_redeem>}}
```

#### Get Points

```json
{ "method": "get_points", "params": {} }
```

### Example

Add 100 points:

```sh
starknet invoke --address <contract_address> --abi <abi_path> --function add_points --inputs 100
```

Retrieve points balance:

```sh
starknet call --address <contract_address> --abi <abi_path> --function get_points
```

---

## License

This project is licensed under the MIT License. See the LICENSE file for details.
