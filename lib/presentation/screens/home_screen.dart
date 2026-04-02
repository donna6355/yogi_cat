import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yogi_cat/constants/extensions.dart';
import 'package:yogi_cat/presentation/components/pose_card.dart';
import 'package:yogi_cat/presentation/components/yoga_space.dart';
import 'package:yogi_cat/presentation/cubit/user_status_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraint) {
            return BlocBuilder<UserStatusCubit, int>(
              builder: (context, stage) {
                return Column(
                  children: [
                    YogaSpace(
                      stage: stage,
                      height: constraint.maxHeight * 0.3,
                      width: constraint.maxWidth,
                    ),
                    Expanded(
                      child: GridView.builder(
                        padding: const EdgeInsets.all(16),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                            ),
                        itemCount: context.list.length,
                        itemBuilder: (context, index) {
                          final pose = context.list[index];
                          return PoseCard(currentStage: stage, pose: pose);
                        },
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
