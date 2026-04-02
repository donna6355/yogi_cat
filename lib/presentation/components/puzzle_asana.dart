import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class PuzzleHint extends StatelessWidget {
  const PuzzleHint({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text('dragNDrop'.tr()),
    );
  }
}

class PuzzleAsana extends StatelessWidget {
  const PuzzleAsana({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
