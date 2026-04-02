import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yogi_cat/presentation/screens/home_screen.dart';
import 'package:yogi_cat/presentation/screens/pose_screen.dart';
import 'package:yogi_cat/presentation/screens/puzzle_screen.dart';
import 'package:yogi_cat/presentation/screens/splash_screen.dart';
import 'package:yogi_cat/presentation/screens/tutorial_screen.dart';

import '../data/pose_model.dart';

class YmRoutes {
  static const String splash = '/';
  static const String home = '/home';
  static const String tutorial = '/tutorial';
  static const String puzzle = '/puzzle';
  static const String pose = '/pose';
}

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: YmRoutes.splash,
      builder: (BuildContext context, GoRouterState state) {
        return const SplashScreen();
      },
    ),
    GoRoute(
      path: YmRoutes.home,
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
    ),
    GoRoute(
      path: YmRoutes.tutorial,
      builder: (BuildContext context, GoRouterState state) {
        return const TutorialScreen();
      },
    ),
    GoRoute(
      path: YmRoutes.puzzle,
      builder: (BuildContext context, GoRouterState state) {
        final asana = state.extra as Pose?;
        return PuzzleScreen(asana!);
      },
    ),
    GoRoute(
      path: YmRoutes.pose,
      builder: (BuildContext context, GoRouterState state) {
        final asana = state.extra as Pose?;
        return PoseScreen(asana!);
      },
    ),
  ],
);
