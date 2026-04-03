import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../data/pose_model.dart';
import '../data/asana_data.dart';
import '../data/sanskrit_data.dart';
import '../data/sanskrit_model.dart';

extension LocaleExtension on BuildContext {
  String get currentLang => locale.languageCode;
  List<Pose> get list =>
      currentLang == 'en' ? AsanaData.asanaEng : AsanaData.asanaKor;
  List<Sanskrit> get sansList =>
      currentLang == 'en' ? SanskritData.sanskritEng : SanskritData.sanskritKor;
}

extension PoseExtension on Pose {
  int get stage => int.parse(id.replaceFirst('ym_', ''));
  String get img => 'assets/pose/$id.webp';
  String get asana => 'assets/sanskrit/$id.webp';
}
