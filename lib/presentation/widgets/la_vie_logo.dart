import 'package:flutter/material.dart';
import 'package:la_vie/presentation/resources/assets_manager.dart';

class LaVieLogo extends StatelessWidget {
  const LaVieLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: const [
        Image(
          image: AssetImage(ImageAssets.laVie),
        ),
        Image(
          image: AssetImage(ImageAssets.plant),
        ),
      ],
    );
  }
}