import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorage{
  final storage = const FlutterSecureStorage();

  Future<bool> setValues(String key, String value) async {
    await storage.write(key: key, value: value);
    return true;
  }

  Future<String?> getValues(String key) async {
    return await storage.read(key: key);
  }

  Future<bool> removeValues(String key) async {
    await storage.delete(key: key);
    return true;
  }

  Future<bool> clearValues() async {
    await storage.deleteAll();
    return true;
  }
}