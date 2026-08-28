# Security and trust model

## Contract properties

The production `DittoCheckpoints` contract is event-only. It has no owner, storage, upgrade path, payable method, or ability to custody or transfer assets.

## Receipt trust model

Automatic receipts are signed by a unique server-managed mirror wallet provisioned for each Ditto user. A demo receipt commits a demo action and action-time demo equity. A real-activity receipt may be created only after a supported venue confirms a real fill; it commits the action metadata and action-time trading-equity snapshot but is not the venue settlement transaction.

Because Ditto controls mirror creation, encrypted key custody, job scheduling, and the private commitment salt, an automatic receipt is tamper-evident Ditto evidence rather than trustless user authorization.

Users can optionally publish a competition score from a connected wallet, which produces a separate user-controlled signature.

## Operational safeguards

- mirror keys are encrypted at rest;
- proof jobs are durable and preserve the action-time equity snapshot;
- jobs are sequential per mirror and concurrent across mirrors;
- Treasury may fund gas but cannot replace the mirror signature;
- points and streaks are awarded only after receipt confirmation;
- gas-funding transfers are excluded from dApp interaction metrics.

## Reporting

Please report security issues privately to `info@dittonetwork.io`. Do not include user identities, wallet private keys, venue credentials, or other secrets in a public GitHub issue.
