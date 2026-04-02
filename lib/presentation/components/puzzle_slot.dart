import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/puzzle_bloc.dart';
import '../bloc/puzzle_event.dart';
import '../bloc/puzzle_state.dart';
import 'puzzle_tile.dart';

class PuzzleSlot extends StatelessWidget {
  final int slot;
  final PuzzlePiece piece;
  final ui.Image image;
  final double cellSize;
  final bool isHovered;
  final bool isCorrect;
  final bool isSolved;

  const PuzzleSlot({
    super.key,
    required this.slot,
    required this.piece,
    required this.image,
    required this.cellSize,
    required this.isHovered,
    required this.isCorrect,
    required this.isSolved,
  });

  Color get _borderColor {
    if (isHovered) return Colors.amber;
    if (isCorrect && !isSolved)
      return Colors.greenAccent.withValues(alpha: 0.6);
    return Colors.deepPurple.withValues(alpha: 0.3);
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<PuzzleBloc>();

    return DragTarget<int>(
      onWillAcceptWithDetails: (details) {
        bloc.add(PuzzleHoverChanged(slot));
        return details.data != slot;
      },
      onLeave: (_) => bloc.add(PuzzleHoverChanged(null)),
      onAcceptWithDetails: (details) =>
          bloc.add(PuzzlePieceSwapped(fromSlot: details.data, toSlot: slot)),
      builder: (context, _, __) => Draggable<int>(
        data: slot,
        feedback: PuzzlePieceTile(
          image: image,
          piece: piece,
          cellSize: cellSize,
          opacity: 0.85,
          elevated: true,
        ),
        childWhenDragging: Container(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            border: Border.all(
              color: Colors.deepPurpleAccent.withValues(alpha: 0.4),
              width: 1,
            ),
          ),
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          decoration: BoxDecoration(
            border: Border.all(color: _borderColor, width: isHovered ? 2.5 : 1),
          ),
          child: PuzzlePieceTile(
            image: image,
            piece: piece,
            cellSize: cellSize,
          ),
        ),
      ),
    );
  }
}
