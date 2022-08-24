import 'package:flutter/material.dart';
import 'package:la_vie/presentation/resources/font_manager.dart';

TextStyle _getTextStyle(Color color, double fontSize, FontWeight fontWeight) {
  return TextStyle(color: color, fontSize: fontSize, fontWeight: fontWeight, fontFamily: FontConstants.fontFamily);
}

TextStyle getBoldStyle({required Color color, double fontSize = FontSize.s14}) {
  return _getTextStyle(color, fontSize, FontWeightManager.bold);
}

TextStyle getMediumStyle({required Color color, double fontSize = FontSize.s14}) {
  return _getTextStyle(color, fontSize, FontWeightManager.medium);
}

TextStyle getRegularStyle({required Color color, double fontSize = FontSize.s14}) {
  return _getTextStyle(color, fontSize, FontWeightManager.regular);
}

TextStyle getLightStyle({required Color color, double fontSize = FontSize.s14}) {
  return _getTextStyle(color, fontSize, FontWeightManager.light);
}