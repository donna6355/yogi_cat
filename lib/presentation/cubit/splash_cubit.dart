import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/local_storage.dart';
import '../../utils/service_locator.dart';

class SplashCubit extends Cubit<bool> {
  final LocalStorage _store;
  SplashCubit({LocalStorage? localSt})
    : _store = localSt ?? getIt<LocalStorage>(),
      super(false) {
    checkFirstVisit();
  }
  Future<void> checkFirstVisit() async {
    await Future.delayed(const Duration(seconds: 1));
    emit(_store.checkFirst());
  }
}
