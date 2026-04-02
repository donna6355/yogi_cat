import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:yogi_cat/constants/constants.dart';

import '../bloc/puzzle_bloc.dart';
import '../components/puzzle_asana.dart';
import '../components/puzzle_grid.dart';
import '../cubit/user_status_cubit.dart';
import '../../data/pose_model.dart';

class PuzzleScreen extends StatelessWidget {
  final Pose asana;
  const PuzzleScreen(this.asana, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          PuzzleBloc(asanas: context.list)
            ..add(PuzzleInitialized(asana: asana)),
      child: const PuzzlePage(),
    );
  }
}

class PuzzlePage extends StatelessWidget {
  const PuzzlePage({super.key});

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
      body: BlocConsumer<PuzzleBloc, PuzzleState>(
        listenWhen: (_, current) => current.cleared,
        listener: (context, state) {
          context.read<UserStatusCubit>().incrementStatus(
            state.currentStage!.stage,
          );
          context.replace(YmRoutes.pose, extra: state.currentStage);
        },
        builder: (context, state) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            switch (state.status) {
              PuzzleStatus.initial || PuzzleStatus.loading =>
                const CircularProgressIndicator(color: Colors.grey),
              PuzzleStatus.ready ||
              PuzzleStatus.solved => PuzzleGrid(state: state),
            },
            SizedBox(width: double.infinity, height: 24),
            state.status == PuzzleStatus.solved
                ? PuzzleAsana(state.options)
                : PuzzleHint(),
          ],
        ),
      ),
    );
  }
}
