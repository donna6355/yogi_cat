import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../constants/constants.dart';
import '../../data/pose_model.dart';
import '../cubit/user_status_cubit.dart';

class PoseScreen extends StatelessWidget {
  final Pose asana;
  const PoseScreen(this.asana, {super.key});

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(16),
              child: Image.asset(asana.img),
            ),
            const SizedBox(height: 8),
            Text(
              asana.sanskrit,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Text(
                asana.name,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Text(asana.content, style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 24),
            if (context.read<UserStatusCubit>().state > asana.stage)
              OutlinedButton(
                onPressed: () => context.replace(YmRoutes.puzzle, extra: asana),
                child: Text("tryAgain".tr()),
              ),
          ],
        ),
      ),
    );
  }
}
