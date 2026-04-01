import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yogi_cat/constants/routes.dart';
import 'package:yogi_cat/utils/service_locator.dart';

import '../../data/local_storage.dart';

class TutorialScreen extends StatelessWidget {
  const TutorialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(
            'Tutorial Screen',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          ElevatedButton(
            onPressed: () {
              getIt<LocalStorage>().tutorialDone();
              context.go(YmRoutes.home);
            },
            child: Text('Start'),
          ),
        ],
      ),
    );
  }
}
