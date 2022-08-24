import 'package:flutter/material.dart';
import 'package:la_vie/presentation/resources/color_manager.dart';
import 'package:la_vie/presentation/resources/font_manager.dart';
import 'package:la_vie/presentation/resources/strings_manager.dart';
import 'package:la_vie/presentation/resources/styles_manager.dart';
import 'package:la_vie/presentation/resources/values_manager.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppPadding.p20),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(AppSize.s5),
        border: Border.all(color: ColorManager.grey9, width: AppSize.s1),
        boxShadow: [BoxShadow(color: ColorManager.black.withOpacity(0.1), spreadRadius: AppSize.s1, blurRadius: AppSize.s5)],
      ),
      width: AppSize.s220,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: AppSize.s20),
          Text(StringManager.pleaseWait, style: getMediumStyle(color: ColorManager.black, fontSize: FontSize.s16)),
        ],
      ),
    );
  }
}