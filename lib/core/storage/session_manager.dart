import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive/hive.dart';

class SessionManager {
  static final String _boxName = dotenv.env['HIVE_SESSION_BOX_NAME'] ?? '';
  static final String _key = dotenv.env['HIVE_SESSION_BOX_KEY'] ?? '';

  Future<void> saveSession(String session) async {
    final openBox = await Hive.openBox(_boxName);
    openBox.put(_key, session);
  }

  Future<String?> getSession(String key) async {
    final openBox = await Hive.openBox(_boxName);
    return openBox.get(key);
  }

  Future<bool> hasSession(String key) async {
    final openBox = await Hive.openBox(_boxName);
    return openBox.containsKey(key);
  }

  Future<void> deleteSession(String key) async {
    final openBox = await Hive.openBox(_boxName);
    openBox.delete(key);
  }
}
