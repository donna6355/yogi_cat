import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../data/pose_model.dart';
import '../data/asana_data.dart';

extension LocaleExtension on BuildContext {
  String get currentLang => locale.languageCode;
  List<Pose> get list =>
      currentLang == 'en' ? AsanaData.asanaEng : AsanaData.asanaKor;
}

extension PoseExtension on Pose {
  int get stage => int.parse(id.replaceFirst('ym_', ''));
  String get img => 'assets/pose/$id.webp';
}
