import 'package:flutter/material.dart';

class LoopingImg extends StatefulWidget {
  final String firstImg;
  final String secondImg;
  const LoopingImg({
    required this.firstImg,
    required this.secondImg,
    super.key,
  });

  @override
  State<LoopingImg> createState() => _LoopingImgState();
}

class _LoopingImgState extends State<LoopingImg>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  // _controller drives one full cycle:
  //   0.00 – 0.25  → show single image (2 sec hold)
  //   0.25 – 0.40  → fade/transition to two images (1.2 sec)
  //   0.40 – 0.65  → show two images (2 sec hold)
  //   0.65 – 0.80  → fade/transition back to single (1.2 sec)
  //   0.80 – 1.00  → padding to complete cycle back to start
  //
  // Total cycle = 8 sec

  /// 0 = fully single, 1 = fully two-image
  late Animation<double> _splitProgress;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 8000),
    )..repeat();

    // Maps the controller's linear 0→1 into a smooth 0→1→0 split value
    _splitProgress = TweenSequence<double>([
      // Hold at 0 (single image) — 2 sec = 25%
      TweenSequenceItem(tween: ConstantTween(0.0), weight: 25),
      // Transition to two images — 1.2 sec = 15%
      TweenSequenceItem(
        tween: Tween(
          begin: 0.0,
          end: 1.0,
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 15,
      ),
      // Hold at 1 (two images) — 2 sec = 25%
      TweenSequenceItem(tween: ConstantTween(1.0), weight: 25),
      // Transition back to one image — 1.2 sec = 15%
      TweenSequenceItem(
        tween: Tween(
          begin: 1.0,
          end: 0.0,
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 15,
      ),
      // Remainder padding — 2 sec = 20%
      TweenSequenceItem(tween: ConstantTween(0.0), weight: 20),
    ]).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _splitProgress,
      builder: (context, _) {
        final t = _splitProgress.value; // 0 = one image, 1 = two images
        return SizedBox(
          width: 260,
          height: 260,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Opacity(opacity: t, child: Image.asset(widget.firstImg)),
              Opacity(opacity: 1.0 - t, child: Image.asset(widget.secondImg)),
            ],
          ),
        );
      },
    );
  }
}
