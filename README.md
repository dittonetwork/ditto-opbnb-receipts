# Ditto opBNB receipts

Public source, ABI, build settings, and production deployment metadata for the on-chain activity receipts created by [Ditto](https://app.dittonetwork.io).

Ditto is a non-custodial trading and wallet-intelligence application. It combines market discovery, demo trading, connected venue execution, competitions, and on-chain activity receipts.

## Production deployment

| Field | Value |
| --- | --- |
| Network | opBNB Mainnet |
| Chain ID | `204` |
| Contract | `DittoCheckpoints` |
| Address | [`0x2648463de873d2d9ea9925f9c75d841193c7d152`](https://opbnb.bscscan.com/address/0x2648463de873d2d9ea9925f9c75d841193c7d152) |
| Deployment transaction | [`0x97fc3ad7a9bd3d86aa2d751fd98e96fb351617fcb9fce750671d3b323c034ea2`](https://opbnb.bscscan.com/tx/0x97fc3ad7a9bd3d86aa2d751fd98e96fb351617fcb9fce750671d3b323c034ea2) |
| Deployment block | `175359333` |
| Deployer / treasury | [`0x2530E4A72587450529FB99518Db39d6a218a4177`](https://opbnb.bscscan.com/address/0x2530E4A72587450529FB99518Db39d6a218a4177) |
| Compiler | Solidity `0.8.26` |
| Optimizer | enabled, `200` runs |
| License | MIT |

The deployment receipt has status `1` and returns the contract address above. The contract address also matches the deterministic CREATE address for the deployer at nonce `114`.

## Contract design

`DittoCheckpoints` is deliberately minimal and event-only:

- no owner or privileged methods;
- no storage;
- no token or user funds;
- no proxy or upgrade path;
- no payable functions.

`stamp(bytes32,uint64)` emits a `Stamped` event from the caller. Ditto uses unique per-user mirror addresses for automatic demo and real-activity receipts. A user may also voluntarily publish a competition score from a connected wallet.

`anchor(bytes32,uint32)` emits an `Anchored` event and is retained for legacy platform receipts.

The `bytes32` root is a private commitment. It does not expose user identity or the underlying action details. Demo and real-activity receipts are classified separately in Ditto's internal analytics.

## What a receipt proves

A confirmed receipt is tamper-evident evidence that Ditto recorded an application action and committed its action-time equity snapshot. It is not:

- venue settlement;
- proof of a real-money trade by itself;
- trustless user authorization when signed by a Ditto-managed mirror;
- financial volume equal to the equity value in the event.

Gas-funding transfers are not dApp interactions and must not be counted as receipt transactions.

## Repository contents

- [`contracts/DittoCheckpoints.sol`](contracts/DittoCheckpoints.sol) — exact deployed source;
- [`abi/DittoCheckpoints.json`](abi/DittoCheckpoints.json) — public ABI;
- [`artifacts/DittoCheckpoints.creation.bin`](artifacts/DittoCheckpoints.creation.bin) — exact creation bytecode;
- [`deployments/opbnb-mainnet.json`](deployments/opbnb-mainnet.json) — deployment evidence and compiler settings;
- [`dappbay.json`](dappbay.json) — DappBay listing metadata;
- [`SECURITY.md`](SECURITY.md) — trust and security disclosure.

## Reproducible build

Using Solidity `0.8.26`:

```bash
solc --optimize --optimize-runs 200 \
  --bin --abi contracts/DittoCheckpoints.sol \
  -o artifacts/rebuilt --overwrite
```

Compare the resulting creation bytecode to `artifacts/DittoCheckpoints.creation.bin`. The committed creation-bytecode SHA-256 is:

```text
890b1b45e024a2f3a4345e9788823ed97bda0c7c7c702e245378981ec903631d
```

The Solidity metadata suffix identifies compiler `0.8.26`.

## Project links

- App: https://app.dittonetwork.io
- Documentation: https://app.dittonetwork.io/docs
- X: https://x.com/Ditto_Network
- Discord: https://discord.gg/64b6tDS8QG
- Support: info@dittonetwork.io

This repository is the public contract package for DappBay review. The consumer application source and private action-to-commitment mappings are not stored here.
