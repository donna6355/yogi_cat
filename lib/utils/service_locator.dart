import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/local_storage.dart';

GetIt getIt = GetIt.instance;
Future<void> serviceLocatorInit() async {
  getIt.registerSingleton<LocalStorage>(
    LocalStorage(await SharedPreferences.getInstance()),
  );
}
