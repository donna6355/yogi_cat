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
      alignment: AlignmentGeometry.center,
      children: [
        Image.asset(
          YmImg.space,
          height: height,
          width: width,
          fit: BoxFit.fill,
        ),
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 460),
          child: Image.asset('assets/space/item_${stage ~/ 2}.webp'),
        ),
        SizedBox(
          height: height,
          width: width,
          child: Padding(
            padding: const EdgeInsets.only(top: 48, bottom: 4),
            child: Image.asset('assets/space/asana_${stage ~/ 5}.webp'),
          ),
        ),
      ],
    );
  }
}
