import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';

import '../../constants/constants.dart';
import '../../utils/email_sender_helper.dart';
import '../../utils/service_locator.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => context.pop(),
          ),
        ],
      ),
      body: Stack(
        children: [
          Image.asset(YmImg.bg, fit: BoxFit.contain),
          Padding(
            padding: EdgeInsetsGeometry.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'greeting'.tr(),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 24, bottom: 8),
                  child: OutlinedButton(
                    onPressed: () => context.replace(YmRoutes.tutorial),
                    child: Text('tutorial'.tr()),
                  ),
                ),
                OutlinedButton(
                  onPressed: () =>
                      getIt<EmailSenderHelper>().sendEmail('subj'.tr()),
                  child: Text('contact'.tr()),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
