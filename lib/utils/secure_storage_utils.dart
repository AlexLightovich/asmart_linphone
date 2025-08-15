import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageUtils {
  final secureStorage = FlutterSecureStorage();

  Future<void> saveSipSettings({
    required String domain,
    required String username,
    required String password,
  }) async {
    await secureStorage.write(key: 'sip_domain', value: domain);
    await secureStorage.write(key: 'sip_username', value: username);
    await secureStorage.write(key: 'sip_password', value: password);
  }

  Future<Map<String, String?>> getSipSettings() async {
    final domain = await secureStorage.read(key: 'sip_domain');
    final username = await secureStorage.read(key: 'sip_username');
    final password = await secureStorage.read(key: 'sip_password');

    return {'domain': domain, 'username': username, 'password': password};
  }

  Future<void> clearSipSettings() async {
    await secureStorage.delete(key: 'sip_domain');
    await secureStorage.delete(key: 'sip_username');
    await secureStorage.delete(key: 'sip_password');
  }
}
