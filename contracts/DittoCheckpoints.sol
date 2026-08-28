// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

/// @title Ditto demo-activity registry
/// @notice The single on-chain convergence point for Ditto's demo activity on
///         opBNB. Event-only by design: no storage, no owner, no funds, no
///         upgrade path — there is nothing here to exploit, drain, or govern.
///         Its entire job is to exist as the countable destination:
///         `Stamped` senders = automatic demo mirrors plus voluntary connected
///         wallets. Those categories must be reported separately off-chain.
/// @dev    `stamp` is called automatically by one server-managed mirror per
///         Ditto user and, optionally, by the user's connected wallet when they
///         publish a demo score. `anchor` remains for legacy receipts. The HMAC
///         leaf keeps user identity and action details private. A mirror stamp
///         is tamper-evident evidence that Ditto recorded a demo action; it is
///         not trustless user authorization and not proof of a real-money trade.
contract DittoCheckpoints {
    /// @notice A mirror or connected wallet published a Ditto demo state.
    /// @param wallet         the signer (indexed — this is the wallet-growth metric)
    /// @param anchorRoot     the treasury-posted attestation root this stamp anchors to
    /// @param equityUsdCents the user's demo competition equity, USD cents
    event Stamped(address indexed wallet, bytes32 anchorRoot, uint64 equityUsdCents);

    /// @notice The platform anchored one demo action's attestation root.
    event Anchored(bytes32 root, uint32 leafCount);

    function stamp(bytes32 anchorRoot, uint64 equityUsdCents) external {
        emit Stamped(msg.sender, anchorRoot, equityUsdCents);
    }

    function anchor(bytes32 root, uint32 leafCount) external {
        emit Anchored(root, leafCount);
    }
}
