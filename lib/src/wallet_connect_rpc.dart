import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:web3dart/json_rpc.dart';

/// Custom RpcService compatible with the web3dart library.
/// Proxy requests to the walletconnect
///
/// Usage example:
/// ```dart
/// final walletConnect = WalletConnect(...);
/// final walletConnectRpc = WalletConnectRpc(walletConnect);
/// final web3client = Web3Client.custom(walletConnectRpc);
/// ```
class WalletConnectRpc extends RpcService {
  final WalletConnect _connector;

  WalletConnectRpc(this._connector);

  @override
  Future<RPCResponse> call(String function, [List? params]) async {
    try {
      final res = await _connector.sendCustomRequest(method: function, params: params ?? []);
      return RPCResponse(0, res);
    } on WalletConnectException catch(e) {
      throw RPCError(e.code, e.message, e.data);
    }
  }
}
