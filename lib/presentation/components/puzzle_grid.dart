import 'package:flutter/material.dart';

import '../bloc/puzzle_bloc.dart';
import '../bloc/puzzle_state.dart';
import 'puzzle_slot.dart';

class PuzzleGrid extends StatelessWidget {
  final PuzzleState state;

  const PuzzleGrid({super.key, required this.state});

  static const int _gridSize = PuzzleBloc.gridSize;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = constraints.maxWidth < constraints.maxHeight
            ? constraints.maxWidth
            : constraints.maxHeight;
        final boardSize = size * 0.92;
        final cellSize = boardSize / _gridSize;

        return Container(
          width: boardSize,
          height: boardSize,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.deepPurpleAccent, width: 2),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.deepPurple.withValues(alpha: 0.5),
                blurRadius: 20,
                spreadRadius: 2,
              ),
            ],
          ),
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: _gridSize,
            ),
            itemCount: PuzzleBloc.totalPieces,
            itemBuilder: (context, slot) => PuzzleSlot(
              slot: slot,
              piece: state.pieces[slot],
              image: state.image!,
              cellSize: cellSize,
              isHovered: state.hoveredSlot == slot,
              isCorrect: state.pieces[slot].id == slot,
              isSolved: state.status == PuzzleStatus.solved,
            ),
          ),
        );
      },
    );
  }
}
