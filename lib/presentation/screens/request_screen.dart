import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../constants/constants.dart';

class RequestScreen extends StatelessWidget {
  const RequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'greeting'.tr(),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                TextField(),
                OutlinedButton(onPressed: () {}, child: Text('contact'.tr())),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
