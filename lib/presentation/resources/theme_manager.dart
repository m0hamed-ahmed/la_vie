import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:la_vie/presentation/resources/color_manager.dart';
import 'package:la_vie/presentation/resources/font_manager.dart';
import 'package:la_vie/presentation/resources/styles_manager.dart';
import 'package:la_vie/presentation/resources/values_manager.dart';

MaterialColor buildMaterialColor(Color color) {
  List<double> strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red;
  final int g = color.green;
  final int b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }

  for (int i = 0; i < strengths.length; i++) {
    double strength = strengths[i];
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}

ThemeData getApplicationTheme() {
  return ThemeData(
    // Main Colors
    primarySwatch: buildMaterialColor(ColorManager.primary),
    scaffoldBackgroundColor: ColorManager.white,

    // AppBar Theme
    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: ColorManager.white, statusBarIconBrightness: Brightness.dark),
      backgroundColor: ColorManager.white,
      elevation: AppSize.s0,
      centerTitle: true,
      titleTextStyle: getBoldStyle(color: ColorManager.black, fontSize: FontSize.s18),
      iconTheme: IconThemeData(color: ColorManager.black),
    ),
  );
}