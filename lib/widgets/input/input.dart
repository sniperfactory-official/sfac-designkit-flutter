import 'package:flutter/material.dart';
import 'package:sfac_design_flutter/sfac_design_flutter.dart';

class SFInput extends StatelessWidget {
  const SFInput({
    super.key,
    this.onChanged,
    this.onFieldSubmitted,
    this.controller,
    this.validator,
    this.width,
    this.label,
    this.labelColor,
    this.labelStyle,
    this.helperText,
    this.helperTextColor,
    this.helperTextStyle,
    this.fillColor,
    this.hintText,
    this.hintColor,
    this.errorText,
    this.errorTextColor,
    this.errorStyle,
    this.obscureText = false,
    this.inputDecorationBorderRadius = 10,
  });

  //onChanged 이벤트
  final Function(String)? onChanged;

  //onFieldSubmitted 이벤트
  final Function(String)? onFieldSubmitted;

  //텍스트 필드 컨트롤러
  final TextEditingController? controller;

  //유효성 검사 validator
  final String? Function(String?)? validator;

  //가로 너비
  final double? width;

  //텍스트필드 위에 Label Text
  final String? label;

  //Label Color
  final Color? labelColor;

  //Label Style
  final TextStyle? labelStyle;

  //텍스트필드 아래 helperText
  final String? helperText;

  //helperText Color
  final Color? helperTextColor;

  //helperText Style
  final TextStyle? helperTextStyle;

  //텍스트필드 색상
  final Color? fillColor;

  //힌트 텍스트
  final String? hintText;

  //힌트 텍스트 색
  final Color? hintColor;

  //에러 텍스트
  final String? errorText;

  //error텍스트 색
  final Color? errorTextColor;

  //error텍스트 Style
  final TextStyle? errorStyle;

  //텍스트 가림 여부
  final bool obscureText;

  //텍스트필드 모서리둥글게
  final double inputDecorationBorderRadius;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Padding(
            padding: const EdgeInsets.only(left: 10, bottom: 3),
            child: Text(
              label!,
              style: labelStyle ??
                  SFTextStyle.b4B14(color: labelColor ?? SFColor.primary80),
            ),
          ),
        SizedBox(
          width: width,
          child: TextFormField(
            onFieldSubmitted: onFieldSubmitted,
            onChanged: onChanged,
            controller: controller,
            obscureText: obscureText,
            validator: validator,
            style: const TextStyle(decorationThickness: 0),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: SFTextStyle.b4M14(
                color: hintColor ?? SFColor.grayScale20,
              ),
              filled: true,
              fillColor: fillColor ?? SFColor.grayScale5,
              helperText: helperText,
              helperStyle: helperTextStyle ??
                  SFTextStyle.b5R12(
                    color: helperTextColor ?? SFColor.grayScale40,
                  ),
              errorText: errorText,
              errorStyle: errorStyle ??
                  SFTextStyle.b5R12(
                    color: errorTextColor ?? SFColor.red,
                  ),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(
                  inputDecorationBorderRadius,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
