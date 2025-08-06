import 'package:hive/hive.dart';

class SessionManager {
  static const String _boxName = 'sessionBox';
  static const String _key = 'session_key';

  late final Box _box;

  Future<void> init() async {
    _box = await Hive.openBox(_boxName);
  }

  Future<void> saveSession(String session) async {
    await _box.put(_key, session);
  }

  String? getSession() {
    return _box.get(_key);
  }

  bool hasSession() {
    return _box.containsKey(_key);
  }

  Future<void> deleteSession() async {
    await _box.delete(_key);
  }
}
