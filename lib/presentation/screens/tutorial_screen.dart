import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/constants/constants.dart';
import '/data/local_storage.dart';
import '/utils/service_locator.dart';

class TutorialScreen extends StatelessWidget {
  const TutorialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  'welcome'.tr(),
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/etc/tutorial_0_${context.currentLang}.webp',
                        width: 200,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        child: Text(
                          'solvePuzzle'.tr(),
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      Image.asset('assets/etc/tutorial_1.webp'),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        child: Text(
                          'itemNAsana'.tr(),
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      Image.asset(
                        'assets/etc/tutorial_2_${context.currentLang}.webp',
                        width: 200,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        child: Text(
                          'learSanskrit'.tr(),
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: OutlinedButton(
                  onPressed: () {
                    getIt<LocalStorage>().tutorialDone();
                    context.go(YmRoutes.home);
                  },
                  child: Text('Start'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
