import 'dart:typed_data';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:web3dart/crypto.dart';
import 'package:web3dart/json_rpc.dart';
import 'package:web3dart/web3dart.dart';

/// Custom Credentials compatible with web3dart library.
/// Responsible for signing/sending transactions to the network using the walletconnect_dart library.
///
/// Usage example:
/// ```dart
/// final walletConnect = WalletConnect(...);
/// final provider = EthereumWalletConnectProvider(_walletConnect);
/// final accounts = _walletConnect.session.accounts;
/// final credentials = WalletConnectCredentials(provider, addressHex: accounts.first);
/// ```
class WalletConnectCredentials extends CredentialsWithKnownAddress implements CustomTransactionSender {
  @override
  final EthereumAddress address;

  final EthereumWalletConnectProvider _provider;

  WalletConnectCredentials(
    this._provider, {
    required String addressHex,
  }) : address = EthereumAddress.fromHex(addressHex);

  @override
  Future<String> sendTransaction(Transaction transaction) async {
    if(transaction.from?.hexEip55 != address.hexEip55) {
      throw Exception('Transaction from != Credentials address');
    }
    try {
      return await _provider.sendTransaction(
        from: transaction.from?.hex ?? address.hex,
        to: transaction.to?.hex,
        data: transaction.data,
        gas: transaction.maxGas,
        gasPrice: transaction.gasPrice?.getInWei,
        value: transaction.value?.getInWei,
        nonce: transaction.nonce,
      );
    } on WalletConnectException catch (e) {
      throw RPCError(e.code, e.message, e.data);
    }
  }

  @override
  Future<MsgSignature> signToSignature(Uint8List payload, {int? chainId, bool isEIP1559 = false}) {
    throw UnimplementedError('Signing raw payloads is not supported');
  }
}
