sealed class PuzzleEvent {}

/// Triggered once on startup to load the asset image and shuffle pieces.
class PuzzleInitialized extends PuzzleEvent {
  final String imgPath;
  PuzzleInitialized({required this.imgPath});
}

/// Player dropped a piece from [fromSlot] onto [toSlot].
class PuzzlePieceSwapped extends PuzzleEvent {
  final int fromSlot;
  final int toSlot;
  PuzzlePieceSwapped({required this.fromSlot, required this.toSlot});
}

/// Player hovered a dragged piece over [hoveredSlot] (null = no hover).
class PuzzleHoverChanged extends PuzzleEvent {
  final int? hoveredSlot;
  PuzzleHoverChanged(this.hoveredSlot);
}
