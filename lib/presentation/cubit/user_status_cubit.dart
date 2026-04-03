import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

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
    _showToast(clearedIdx);
    _store.saveSolved(state + 1);
    emit(state + 1);
  }

  void _showToast(int clearedIdx) {
    //idx is 5x -> new asana learned
    if (clearedIdx % 5 == 0) {
      toastification.show(
        type: ToastificationType.success,
        style: ToastificationStyle.flatColored,
        title: Text('newAsana'.tr(), textAlign: TextAlign.center),
        autoCloseDuration: const Duration(seconds: 3),
        showIcon: false,
        closeButton: ToastCloseButton(showType: CloseButtonShowType.none),
      );
      return;
    }
    //idx is even -> item added
    if (clearedIdx.isEven) {
      toastification.show(
        type: ToastificationType.success,
        style: ToastificationStyle.flatColored,
        title: Text('newItem'.tr(), textAlign: TextAlign.center),
        autoCloseDuration: const Duration(seconds: 3),
        showIcon: false,
        closeButton: ToastCloseButton(showType: CloseButtonShowType.none),
      );
      return;
    }
    toastification.show(
      type: ToastificationType.success,
      style: ToastificationStyle.flatColored,
      title: Text('correct'.tr(), textAlign: TextAlign.center),
      autoCloseDuration: const Duration(seconds: 3),
      showIcon: false,
      closeButton: ToastCloseButton(showType: CloseButtonShowType.none),
    );
  }
}
