import 'package:flutter/material.dart';
import 'package:sfac_design_flutter/sfac_design_flutter.dart';

class SFInput extends StatelessWidget {
  const SFInput({
    super.key,
    this.controller,
    this.withText = false,
    this.helperTextColor,
    this.helperTextStyle,
    this.withLabel = false,
    this.labelColor,
    this.labelStyle,
    this.width,
    this.label,
    this.fillColor,
    required this.hintText,
    this.hintColor,
    this.errorText,
    this.errorStyle,
    this.onChanged,
    this.obscureText = false,
    this.errorTextColor,
    this.helperText,
    this.inputDecorationBorderRadius = 10,
  });

  //텍스트 필드 컨트롤러
  final TextEditingController? controller;

  //helperText와 함께 쓰이는지에 대한 bool값
  final bool? withText;

  //helperText Color
  final Color? helperTextColor;

  //helperText Style
  final TextStyle? helperTextStyle;

  //Label과 함께 쓰이는지에 대한 bool값
  final bool? withLabel;

  //Label Color(withLabel값을 true로 해야 보인다.)
  final Color? labelColor;

  //Label Style(withLabel값을 true로 해야 보인다.)
  final TextStyle? labelStyle;

  //텍스트필드 위에 Label Text(withLabel값을 true로 해야 보인다.)
  final String? label;

  //가로 너비
  final double? width;

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

  //onChanged 이벤트
  final Function(String)? onChanged;

  //텍스트 가림 여부
  final bool obscureText;

  //텍스트필드 아래 helperText
  final String? helperText;

  //텍스트필드 모서리둥글게
  final double inputDecorationBorderRadius;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (withLabel == true)
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
            onChanged: onChanged,
            controller: controller,
            obscureText: obscureText,
            style: const TextStyle(decorationThickness: 0),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: SFTextStyle.b4M14(
                color: hintColor ?? SFColor.grayScale20,
              ),
              filled: true,
              fillColor: fillColor ?? SFColor.grayScale5,
              helperText: withText == true ? helperText : '',
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
