import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../bloc/puzzle_bloc.dart';

class PuzzlePieceTile extends StatelessWidget {
  final ui.Image image;
  final PuzzlePiece piece;
  final double cellSize;
  final double opacity;
  final bool elevated;

  const PuzzlePieceTile({
    super.key,
    required this.image,
    required this.piece,
    required this.cellSize,
    this.opacity = 1.0,
    this.elevated = false,
  });

  static const int _gridSize = PuzzleBloc.gridSize;

  @override
  Widget build(BuildContext context) {
    final row = piece.id ~/ _gridSize;
    final col = piece.id % _gridSize;

    Widget tile = SizedBox(
      width: cellSize,
      height: cellSize,
      child: CustomPaint(
        painter: _PiecePainter(
          image: image,
          row: row,
          col: col,
          gridSize: _gridSize,
        ),
      ),
    );

    if (opacity < 1.0) tile = Opacity(opacity: opacity, child: tile);
    if (elevated) {
      tile = Material(elevation: 12, shadowColor: Colors.black87, child: tile);
    }

    return tile;
  }
}

// ─────────────────────────────────────────────
// _PiecePainter
// ─────────────────────────────────────────────

class _PiecePainter extends CustomPainter {
  final ui.Image image;
  final int row;
  final int col;
  final int gridSize;

  const _PiecePainter({
    required this.image,
    required this.row,
    required this.col,
    required this.gridSize,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final pieceW = image.width / gridSize;
    final pieceH = image.height / gridSize;

    final src = Rect.fromLTWH(col * pieceW, row * pieceH, pieceW, pieceH);
    final dst = Rect.fromLTWH(0, 0, size.width, size.height);

    canvas.drawImageRect(image, src, dst, Paint());
  }

  @override
  bool shouldRepaint(_PiecePainter old) =>
      old.image != image || old.row != row || old.col != col;
}
