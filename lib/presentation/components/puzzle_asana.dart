import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/pose_model.dart';
import '../bloc/puzzle_bloc.dart';

class PuzzleHint extends StatelessWidget {
  const PuzzleHint({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        'dragNDrop'.tr(),
        style: Theme.of(context).textTheme.titleLarge,
        textAlign: TextAlign.center,
      ),
    );
  }
}

class PuzzleAsana extends StatelessWidget {
  final List<Pose> options;
  const PuzzleAsana(this.options, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: options.indexed
          .map(
            (option) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: ShakeWidget(
                key: context.read<PuzzleBloc>().shakeKeys[option.$1],
                child: OutlinedButton(
                  onPressed: () {
                    context.read<PuzzleBloc>().add(
                      PuzzleAsanaSelected(selected: option.$2, idx: option.$1),
                    );
                  },
                  child: AutoSizeText(option.$2.sanskrit, maxLines: 1),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

class ShakeWidget extends StatefulWidget {
  final Widget child;
  const ShakeWidget({super.key, required this.child});
  @override
  State<ShakeWidget> createState() => ShakeWidgetState();
}

class ShakeWidgetState extends State<ShakeWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 400),
  );

  late final Animation<double> _offset = TweenSequence([
    TweenSequenceItem(tween: Tween(begin: 0.0, end: -8.0), weight: 1),
    TweenSequenceItem(tween: Tween(begin: -8.0, end: 8.0), weight: 2),
    TweenSequenceItem(tween: Tween(begin: 8.0, end: -6.0), weight: 2),
    TweenSequenceItem(tween: Tween(begin: -6.0, end: 6.0), weight: 2),
    TweenSequenceItem(tween: Tween(begin: 6.0, end: 0.0), weight: 1),
  ]).animate(_controller);

  void shake() => _controller.forward(from: 0);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _offset,
      builder: (context, child) =>
          Transform.translate(offset: Offset(_offset.value, 0), child: child),
      child: widget.child,
    );
  }
}
