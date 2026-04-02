import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../constants/constants.dart';
import '../../data/pose_model.dart';

class PoseCard extends StatelessWidget {
  final int currentStage;
  final Pose pose;
  const PoseCard({required this.currentStage, required this.pose, super.key});

  @override
  Widget build(BuildContext context) {
    final bool isLocked = currentStage + 1 < pose.stage;
    return GestureDetector(
      onTap: () {
        if (isLocked) return;
        final isSolved = currentStage >= pose.stage;
        context.push(isSolved ? YmRoutes.pose : YmRoutes.puzzle, extra: pose);
      },
      child: ClipRRect(
        borderRadius: BorderRadiusGeometry.circular(8),
        child: Stack(
          children: [
            Image.asset(pose.img),
            if (currentStage >= pose.stage)
              ColoredBox(color: Colors.black26, child: Image.asset(YmImg.comp)),
            if (isLocked)
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
                child: ColoredBox(
                  color: Colors.black45,
                  child: Center(
                    child: Icon(
                      Icons.lock_rounded,
                      color: Colors.white70,
                      size: 32,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
