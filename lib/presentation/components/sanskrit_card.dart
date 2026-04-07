import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../constants/constants.dart';
import '../../data/pose_model.dart';
import '../../data/sanskrit_model.dart';

class SanskritCard extends StatelessWidget {
  final Sanskrit sanskrit;
  final List<Pose> linkedAsanas;

  const SanskritCard({
    required this.sanskrit,
    required this.linkedAsanas,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              sanskrit.sanskrit,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(width: 8),
            Text(
              sanskrit.meaning,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
        children: [
          ...linkedAsanas.map(
            (pose) => Padding(
              padding: const EdgeInsets.only(top: 4),
              child: GestureDetector(
                onTap: () => context.push(YmRoutes.pose, extra: pose),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: ClipRRect(
                        borderRadius: BorderRadiusGeometry.circular(4),
                        child: Image.asset(pose.asana, width: 80, height: 80),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            pose.sanskrit,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),

                          Text(
                            pose.content,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 8),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
