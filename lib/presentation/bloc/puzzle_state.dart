import 'dart:ui' as ui;

class PuzzlePiece {
  final int id; // original position in the image grid (0-based)
  final int currentIndex; // current slot position (0-based)

  const PuzzlePiece({required this.id, required this.currentIndex});

  PuzzlePiece copyWith({int? id, int? currentIndex}) => PuzzlePiece(
    id: id ?? this.id,
    currentIndex: currentIndex ?? this.currentIndex,
  );
}

enum PuzzleStatus { initial, loading, ready, solved }

class PuzzleState {
  final PuzzleStatus status;
  final List<PuzzlePiece> pieces; // indexed by slot
  final ui.Image? image;
  final int? hoveredSlot;

  const PuzzleState({
    this.status = PuzzleStatus.initial,
    this.pieces = const [],
    this.image,
    this.hoveredSlot,
  });

  PuzzleState copyWith({
    PuzzleStatus? status,
    List<PuzzlePiece>? pieces,
    ui.Image? image,
    int? hoveredSlot,
    bool clearHover = false,
  }) => PuzzleState(
    status: status ?? this.status,
    pieces: pieces ?? this.pieces,
    image: image ?? this.image,
    hoveredSlot: clearHover ? null : (hoveredSlot ?? this.hoveredSlot),
  );
}
