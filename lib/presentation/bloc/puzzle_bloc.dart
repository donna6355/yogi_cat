import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/constants.dart';
import '../../data/pose_model.dart';
import '../components/puzzle_asana.dart';

part 'puzzle_event.dart';
part 'puzzle_state.dart';

class PuzzleBloc extends Bloc<PuzzleEvent, PuzzleState> {
  static const int gridSize = 4;
  static const int totalPieces = gridSize * gridSize;
  final List<Pose> asanas;
  final shakeKeys = List.generate(4, (_) => GlobalKey<ShakeWidgetState>());

  PuzzleBloc({required this.asanas}) : super(const PuzzleState()) {
    on<PuzzleInitialized>(_onInitialized);
    on<PuzzlePieceSwapped>(_onPieceSwapped);
    on<PuzzleHoverChanged>(_onHoverChanged);
    on<PuzzleAsanaSelected>(_onAsanaSelected);
  }

  // ── Load image then shuffle ──
  Future<void> _onInitialized(
    PuzzleInitialized event,
    Emitter<PuzzleState> emit,
  ) async {
    emit(state.copyWith(status: PuzzleStatus.loading));

    final image = await _loadAssetImage(event.asana.img);
    final pieces = _buildShuffledPieces();
    final options = _asanaHints(event.asana);

    emit(
      state.copyWith(
        status: PuzzleStatus.ready,
        image: image,
        pieces: pieces,
        options: options,
        currentStage: event.asana,
      ),
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

  void _onAsanaSelected(PuzzleAsanaSelected event, Emitter<PuzzleState> emit) {
    final Pose selected = event.selected;
    if (selected.stage != state.currentStage!.stage) {
      shakeKeys[event.idx].currentState?.shake();
    } else {
      emit(state.copyWith(cleared: true));
    }
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

  List<Pose> _asanaHints(Pose currentStage) {
    final list = List<Pose>.from(asanas)..removeAt(currentStage.stage - 1);
    list.shuffle();
    final answers = list.take(3).toList();
    answers.add(currentStage);
    answers.shuffle();
    return answers;
  }
}
