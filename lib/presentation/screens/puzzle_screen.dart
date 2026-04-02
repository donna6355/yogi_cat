import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/puzzle_bloc.dart';
import '../bloc/puzzle_event.dart';
import '../bloc/puzzle_state.dart';
import '../components/puzzle_asana.dart';
import '../components/puzzle_grid.dart';

class PuzzleScreen extends StatelessWidget {
  final String imgPath;
  const PuzzleScreen(this.imgPath, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PuzzleBloc()..add(PuzzleInitialized(imgPath: imgPath)),
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
      body: BlocBuilder<PuzzleBloc, PuzzleState>(
        builder: (context, state) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            switch (state.status) {
              PuzzleStatus.initial || PuzzleStatus.loading =>
                const CircularProgressIndicator(color: Colors.white),
              PuzzleStatus.ready ||
              PuzzleStatus.solved => PuzzleGrid(state: state),
            },
            SizedBox(width: double.infinity, height: 24),
            state.status == PuzzleStatus.solved ? SizedBox() : PuzzleHint(),
          ],
        ),
      ),
    );
  }
}
