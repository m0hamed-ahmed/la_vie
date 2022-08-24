import 'package:flutter/material.dart';
import 'package:la_vie/presentation/resources/color_manager.dart';
import 'package:la_vie/presentation/resources/values_manager.dart';
import 'package:la_vie/presentation/widgets/custom_button.dart';

class CategoryItem extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final bool isSelected;

  const CategoryItem({
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
        buttonColor: isSelected ? ColorManager.white : ColorManager.grey5,
        textColor: isSelected ? ColorManager.primary : ColorManager.grey4,
        borderColor: isSelected ? ColorManager.primary : Colors.transparent,
        width: AppSize.s100,
        text: text,
        elevation: AppSize.s0,
        radius: AppSize.s10,
      ),
    );
  }
}