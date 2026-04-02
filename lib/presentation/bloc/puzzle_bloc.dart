import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'puzzle_event.dart';
import 'puzzle_state.dart';

class PuzzleBloc extends Bloc<PuzzleEvent, PuzzleState> {
  static const int gridSize = 4;
  static const int totalPieces = gridSize * gridSize;

  PuzzleBloc() : super(const PuzzleState()) {
    on<PuzzleInitialized>(_onInitialized);
    on<PuzzlePieceSwapped>(_onPieceSwapped);
    on<PuzzleHoverChanged>(_onHoverChanged);
  }

  // ── Load image then shuffle ──
  Future<void> _onInitialized(
    PuzzleInitialized event,
    Emitter<PuzzleState> emit,
  ) async {
    emit(state.copyWith(status: PuzzleStatus.loading));

    final image = await _loadAssetImage(event.imgPath);
    final pieces = _buildShuffledPieces();

    emit(
      state.copyWith(status: PuzzleStatus.ready, image: image, pieces: pieces),
    );
  }

  void _onPieceSwapped(PuzzlePieceSwapped event, Emitter<PuzzleState> emit) {
    final from = event.fromSlot;
    final to = event.toSlot;
    if (from == to) return;

    final pieces = List<PuzzlePiece>.from(state.pieces);
    final tmp = pieces[from];
    pieces[from] = pieces[to].copyWith(currentIndex: from);
    pieces[to] = tmp.copyWith(currentIndex: to);

    final solved = pieces.every((p) => p.id == p.currentIndex);

    emit(
      state.copyWith(
        pieces: pieces,
        status: solved ? PuzzleStatus.solved : PuzzleStatus.ready,
        clearHover: true,
      ),
    );
  }

  void _onHoverChanged(PuzzleHoverChanged event, Emitter<PuzzleState> emit) {
    emit(
      state.copyWith(
        hoveredSlot: event.hoveredSlot,
        clearHover: event.hoveredSlot == null,
      ),
    );
  }

  // ── Helpers ──

  List<PuzzlePiece> _buildShuffledPieces() {
    final indices = List<int>.generate(totalPieces, (i) => i)..shuffle();
    return List.generate(
      totalPieces,
      (slot) => PuzzlePiece(id: indices[slot], currentIndex: slot),
    );
  }

  Future<ui.Image> _loadAssetImage(String assetPath) async {
    final completer = Completer<ui.Image>();
    final stream = AssetImage(assetPath).resolve(const ImageConfiguration());
    late ImageStreamListener listener;
    listener = ImageStreamListener((info, _) {
      completer.complete(info.image);
      stream.removeListener(listener);
    });
    stream.addListener(listener);
    return completer.future;
  }
}
