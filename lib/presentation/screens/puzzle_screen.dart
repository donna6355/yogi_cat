import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:go_router/go_router.dart';

// ─────────────────────────────────────────────
// Data model for a single puzzle piece
// ─────────────────────────────────────────────
class PuzzlePiece {
  final int id; // 0-based index in the original image
  int currentIndex; // current position in the grid (0-based)

  PuzzlePiece({required this.id, required this.currentIndex});
}

// ─────────────────────────────────────────────
// Main puzzle screen
// ─────────────────────────────────────────────
class PuzzleScreen extends StatefulWidget {
  final String img;
  const PuzzleScreen(this.img, {super.key});

  @override
  State<PuzzleScreen> createState() => _PuzzleScreenState();
}

class _PuzzleScreenState extends State<PuzzleScreen> {
  static const int gridSize = 4;
  static const int totalPieces = gridSize * gridSize; // 16

  // Pieces ordered by their currentIndex (slot 0 … 15)
  late List<PuzzlePiece> _pieces;

  ui.Image? _image;
  bool _imageLoaded = false;
  bool _solved = false;

  // Track which slot is currently being hovered by a drag
  int? _hoveredSlot;

  @override
  void initState() {
    super.initState();
    _initPieces();
    _loadImage();
  }

  // ── Initialise pieces in a shuffled order ──
  void _initPieces() {
    final indices = List<int>.generate(totalPieces, (i) => i)..shuffle();
    _pieces = List.generate(
      totalPieces,
      (slot) => PuzzlePiece(id: indices[slot], currentIndex: slot),
    );
    _solved = false;
  }

  // ── Load a network image into a ui.Image ──
  Future<void> _loadImage() async {
    // // Using a public domain painting as demo image
    // const url =
    //     'https://upload.wikimedia.org/wikipedia/commons/thumb/e/ec/Mona_Lisa%2C_by_Leonardo_da_Vinci%2C_from_C2RMF_retouched.jpg/402px-Mona_Lisa%2C_by_Leonardo_da_Vinci%2C_from_C2RMF_retouched.jpg';

    // final imageProvider = NetworkImage(url);

    final imageProvider = AssetImage(widget.img);
    final stream = imageProvider.resolve(const ImageConfiguration());

    stream.addListener(
      ImageStreamListener((info, _) {
        if (mounted) {
          setState(() {
            _image = info.image;
            _imageLoaded = true;
          });
        }
      }),
    );
  }

  // ── Swap two slots ──
  void _swapPieces(int fromSlot, int toSlot) {
    if (fromSlot == toSlot) return;
    setState(() {
      final tmp = _pieces[fromSlot];
      _pieces[fromSlot] = _pieces[toSlot];
      _pieces[toSlot] = tmp;
      _pieces[fromSlot].currentIndex = fromSlot;
      _pieces[toSlot].currentIndex = toSlot;
      _solved = _checkSolved();
    });
  }

  bool _checkSolved() => _pieces.every((p) => p.id == p.currentIndex);

  // ─────────────────────────────────────────────
  // Build
  // ─────────────────────────────────────────────
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _imageLoaded && _image != null
              ? _buildPuzzleGrid()
              : const CircularProgressIndicator(color: Colors.black87),
          SizedBox(width: double.infinity, height: 24),
          _solved ? SizedBox() : _buildHint(),
        ],
      ),
    );
  }

  Widget _buildHint() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text('dragNDrop'.tr()),
    );
  }

  // ── Puzzle grid ──
  Widget _buildPuzzleGrid() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = constraints.maxWidth < constraints.maxHeight
            ? constraints.maxWidth
            : constraints.maxHeight;
        final boardSize = size * 0.92;
        final cellSize = boardSize / gridSize;

        return Container(
          width: boardSize,
          height: boardSize,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black87, width: 2),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black87.withValues(alpha: 0.5),
                blurRadius: 20,
                spreadRadius: 2,
              ),
            ],
          ),
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: gridSize,
            ),
            itemCount: totalPieces,
            itemBuilder: (context, slot) {
              return _buildSlot(slot, cellSize);
            },
          ),
        );
      },
    );
  }

  // ── One grid slot: acts as both DragTarget and Draggable ──
  Widget _buildSlot(int slot, double cellSize) {
    final piece = _pieces[slot];
    final isCorrect = piece.id == slot;
    final isHovered = _hoveredSlot == slot;

    return DragTarget<int>(
      onWillAcceptWithDetails: (details) {
        setState(() => _hoveredSlot = slot);
        return details.data != slot;
      },
      onLeave: (_) => setState(() => _hoveredSlot = null),
      onAcceptWithDetails: (details) {
        setState(() => _hoveredSlot = null);
        _swapPieces(details.data, slot);
      },
      builder: (context, candidateData, rejectedData) {
        return Draggable<int>(
          data: slot,
          feedback: _buildPieceTile(
            piece,
            cellSize,
            opacity: 0.85,
            elevated: true,
          ),
          childWhenDragging: Container(
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              border: Border.all(
                color: Colors.black87.withValues(alpha: 0.4),
                width: 1,
              ),
            ),
          ),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            decoration: BoxDecoration(
              border: Border.all(
                color: isHovered
                    ? Colors.lightBlueAccent
                    : isCorrect && !_solved
                    ? Colors.black87.withValues(alpha: 0.6)
                    : Colors.redAccent.withValues(alpha: 0.3),
                width: isHovered ? 2.5 : 1,
              ),
            ),
            child: _buildPieceTile(piece, cellSize),
          ),
        );
      },
    );
  }

  // ── Renders a piece using CustomPaint to crop the correct region ──
  Widget _buildPieceTile(
    PuzzlePiece piece,
    double cellSize, {
    double opacity = 1.0,
    bool elevated = false,
  }) {
    final row = piece.id ~/ gridSize;
    final col = piece.id % gridSize;

    Widget tile = SizedBox(
      width: cellSize,
      height: cellSize,
      child: CustomPaint(
        painter: _PiecePainter(
          image: _image!,
          row: row,
          col: col,
          gridSize: gridSize,
        ),
      ),
    );

    if (opacity < 1.0) {
      tile = Opacity(opacity: opacity, child: tile);
    }

    if (elevated) {
      tile = Material(elevation: 12, shadowColor: Colors.black87, child: tile);
    }

    return tile;
  }
}

// ─────────────────────────────────────────────
// CustomPainter: crops and draws one piece
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
