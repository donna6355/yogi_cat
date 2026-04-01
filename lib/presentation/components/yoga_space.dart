import 'package:flutter/material.dart';
import 'package:yogi_cat/constants/images.dart';

class YogaSpace extends StatelessWidget {
  final int stage;
  final double height;
  final double width;

  const YogaSpace({
    required this.stage,
    required this.height,
    required this.width,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          YmImg.space,
          height: height,
          width: width,
          fit: BoxFit.fill,
        ),
      ],
    );
  }
}
