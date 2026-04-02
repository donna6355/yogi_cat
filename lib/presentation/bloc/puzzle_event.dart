import '../../data/pose_model.dart';

sealed class PuzzleEvent {}

/// Triggered once on startup to load the asset image and shuffle pieces.
class PuzzleInitialized extends PuzzleEvent {
  final Pose asana;
  PuzzleInitialized({required this.asana});
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

/// Player select an asana option.
class PuzzleAsanaSelected extends PuzzleEvent {
  final Pose selected;
  final int idx;
  PuzzleAsanaSelected({required this.selected, required this.idx});
}
