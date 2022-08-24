import 'package:flutter/material.dart';
import 'package:la_vie/presentation/resources/color_manager.dart';
import 'package:la_vie/presentation/resources/strings_manager.dart';
import 'package:la_vie/presentation/resources/styles_manager.dart';
import 'package:la_vie/presentation/resources/values_manager.dart';

// ignore: must_be_immutable
class CustomTextFormField extends StatelessWidget {
  final bool enabled;
  final TextEditingController controller;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final bool obscureText;
  final int maxLines;
  final String hint;
  final Color fillColor;
  final Color borderColor;
  final double borderRadius;
  IconData? prefixIcon;
  Color prefixIconColor;
  final Widget? suffix;
  Function(String)? onFieldSubmitted;
  Function(String)? onChanged;
  String? Function(String?)? validator;
  final bool isValidatorRequired;

  CustomTextFormField({
    Key? key,
    this.enabled = true,
    required this.controller,
    this.textInputType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.obscureText = false,
    this.maxLines = 1,
    this.hint = '',
    this.fillColor = Colors.white,
    this.borderColor = const Color(0xff939393),
    this.borderRadius = 5.0,
    this.prefixIcon,
    this.prefixIconColor = const Color(0xff1ABC00),
    this.suffix,
    this.onFieldSubmitted,
    this.onChanged,
    this.validator,
    this.isValidatorRequired = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.centerEnd,
      children: [
        TextFormField(
          enabled: enabled,
          controller: controller,
          keyboardType: textInputType,
          textInputAction: textInputAction,
          maxLines: maxLines,
          obscureText: obscureText,
          cursorColor: ColorManager.primary,
          validator: isValidatorRequired ? (val) {
            if(val!.trim().isEmpty) {return StringManager.required;}
            return null;
          } : validator,
          onChanged: onChanged,
          onFieldSubmitted: onFieldSubmitted,
          style: getMediumStyle(color: ColorManager.black),
          decoration: InputDecoration(
            filled: true,
            fillColor: fillColor,
            contentPadding: EdgeInsetsDirectional.only(
              top: AppPadding.p20,
              start: prefixIcon == null && suffix != null ? AppPadding.p40 : AppPadding.p20,
              end: AppPadding.p20,
            ),
            prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: prefixIconColor) : null,
            hintText: hint,
            hintStyle: getMediumStyle(color: ColorManager.grey4),
            errorStyle: getMediumStyle(color: ColorManager.red700),
            border: OutlineInputBorder(borderSide: BorderSide(color: borderColor), borderRadius: BorderRadius.circular(borderRadius)),
            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: borderColor), borderRadius: BorderRadius.circular(borderRadius)),
            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: borderColor), borderRadius: BorderRadius.circular(borderRadius)),
            errorBorder: OutlineInputBorder(borderSide: BorderSide(color: ColorManager.red700), borderRadius: BorderRadius.circular(borderRadius)),
            focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: ColorManager.red700), borderRadius: BorderRadius.circular(borderRadius)),
          ),
        ),
        if(suffix != null) suffix!,
      ],
    );
  }
}