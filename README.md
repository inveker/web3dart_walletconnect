# Description

Implementing a web3dart connection with walletconnect

# Installation

pubspec.yaml

```yaml
dependencies:
    web3dart_walletconnect:
        git: https://github.com/inveker/web3dart_walletconnect
```

# Usage

## WalletConnectCredentials

```dart
final walletConnect = WalletConnect(...);
final provider = EthereumWalletConnectProvider(walletConnect);
final accounts = walletConnect.session.accounts;
final credentials = WalletConnectCredentials(provider, addressHex: accounts.first);
```

## WalletConnectRpc

```dart
final walletConnect = WalletConnect(...);
final walletConnectRpc = WalletConnectRpc(walletConnect);
final web3client = Web3Client.custom(walletConnectRpc);
```