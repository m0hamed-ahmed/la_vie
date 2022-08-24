import 'package:flutter/material.dart';
import 'package:la_vie/presentation/resources/color_manager.dart';
import 'package:la_vie/presentation/resources/values_manager.dart';
import 'package:la_vie/presentation/widgets/custom_button.dart';

class ForumItem extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final bool isSelected;

  const ForumItem({
    Key? key,
    required this.text,
    this.onPressed,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: AppMargin.m8),
      child: CustomButton(
        onPressed: onPressed,
        buttonColor: isSelected ? ColorManager.primary : ColorManager.white,
        textColor: isSelected ? ColorManager.white : ColorManager.grey1,
        borderColor: isSelected ? ColorManager.primary : ColorManager.grey7,
        width: AppSize.s100,
        height: AppSize.s35,
        text: text,
        elevation: AppSize.s0,
        radius: AppSize.s10,
      ),
    );
  }
}