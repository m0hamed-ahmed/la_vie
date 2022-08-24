import 'package:flutter/material.dart';
import 'package:la_vie/presentation/resources/values_manager.dart';

class BottomAppBarItem extends StatelessWidget {
  final String image;
  final void Function()? onTap;

  const BottomAppBarItem({
    Key? key,
    required this.image,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppSize.s40,
      height: AppSize.s40,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Image.asset(image),
        ),
      ),
    );
  }
}