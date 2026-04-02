import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/local_storage.dart';
import '../../utils/service_locator.dart';

class UserStatusCubit extends Cubit<int> {
  final LocalStorage _store;
  UserStatusCubit({LocalStorage? localSt})
    : _store = localSt ?? getIt<LocalStorage>(),
      super(0) {
    emit(_store.getSolved());
  }

  void incrementStatus(int clearedIdx) {
    if (clearedIdx != state + 1) return;
    //TODO toast message
    _store.saveSolved(state + 1);
    emit(state + 1);
  }
}
