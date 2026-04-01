import 'package:shared_preferences/shared_preferences.dart';

enum StorageKey { isFirst, solved }

class LocalStorage {
  final SharedPreferences _store;
  LocalStorage(this._store);

  bool checkFirst() => _store.getBool(StorageKey.isFirst.name) ?? true;
  Future<void> tutorialDone() async =>
      _store.setBool(StorageKey.isFirst.name, false);

  int getSolved() => _store.getInt(StorageKey.solved.name) ?? 0;
  Future<void> saveSolved(int solved) async =>
      _store.setInt(StorageKey.solved.name, solved);
}
