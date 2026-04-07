import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../constants/constants.dart';
import '../../data/pose_model.dart';
import '../components/looping_img.dart';
import '../cubit/user_status_cubit.dart';

class PoseScreen extends StatelessWidget {
  final Pose asana;
  const PoseScreen(this.asana, {super.key});

  @override
  Widget build(BuildContext context) {
    final currentStage = context.read<UserStatusCubit>().state;
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
              child: LoopingImg(firstImg: asana.img, secondImg: asana.asana),
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
            if (currentStage >= asana.stage)
              Row(
                children: [
                  TextButton(
                    onPressed: () =>
                        context.replace(YmRoutes.puzzle, extra: asana),
                    child: Row(
                      children: [
                        Icon(Icons.refresh),
                        SizedBox(width: 4),
                        Text("tryAgain".tr()),
                      ],
                    ),
                  ),
                  SizedBox(width: 12),
                  asana.stage == context.list.length
                      ? OutlinedButton(
                          onPressed: () => context.replace(YmRoutes.request),
                          child: Text("atTheEnd".tr()),
                        )
                      : OutlinedButton(
                          onPressed: () => context.replace(
                            YmRoutes.puzzle,
                            extra: context.list[asana.stage],
                          ),
                          child: Text("goToNext".tr()),
                        ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
