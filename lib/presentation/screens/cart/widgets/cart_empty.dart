import 'package:flutter/material.dart';
import 'package:la_vie/presentation/resources/assets_manager.dart';
import 'package:la_vie/presentation/resources/color_manager.dart';
import 'package:la_vie/presentation/resources/font_manager.dart';
import 'package:la_vie/presentation/resources/strings_manager.dart';
import 'package:la_vie/presentation/resources/styles_manager.dart';
import 'package:la_vie/presentation/resources/values_manager.dart';

class CartEmpty extends StatelessWidget {
  const CartEmpty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(ImageAssets.empty),
            const SizedBox(height: AppSize.s20),
            Text(StringManager.yourCartIsEmpty, style: getBoldStyle(color: ColorManager.black, fontSize: FontSize.s24)),
            const SizedBox(height: AppSize.s20),
            Text(StringManager.sorryNotFound, textAlign: TextAlign.center, style: getRegularStyle(color: ColorManager.grey1, fontSize: FontSize.s18)),
          ],
        ),
      ),
    );
  }
}