import 'package:flutter/material.dart';

class BackgroundShape extends StatelessWidget {
  final AlignmentGeometry alignment;
  final String image;

  const BackgroundShape({Key? key, required this.alignment, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Image.asset(image),
    );
  }
}