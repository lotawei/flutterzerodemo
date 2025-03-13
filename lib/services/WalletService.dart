// lib/services/wallet_service.dart
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:web3dart/credentials.dart';

class WalletService {
  final _storage = const FlutterSecureStorage();

  Future<Credentials?> getCredentials(String privateKey) async {
    try {
      return EthPrivateKey.fromHex(privateKey);
    } catch (e) {
      print("Invalid private key format");
      return null;
    }
  }

  Future<void> savePrivateKey(String key) async {
    await _storage.write(key: 'private_key', value: key);
  }

  Future<String?> getPrivateKey() async {
    return await _storage.read(key: 'private_key');
  }
}
