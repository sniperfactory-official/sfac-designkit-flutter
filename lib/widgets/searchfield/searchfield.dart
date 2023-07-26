import 'package:flutter/material.dart';
import 'package:sfac_design_flutter/sfac_design_flutter.dart';

class SFSearchField extends StatefulWidget {
  const SFSearchField({
    super.key,
    this.controller,
    this.hintText,
    this.hintColor,
    this.onChanged,
    this.onSubmitted,
    this.outlineWidth,
    this.radius,
    this.width,
    this.suffixIcon,
    this.focusIconColor,
    this.enabledIconColor,
    this.focusBorderColor,
    this.enabledBorderColor,
    this.fillColor,
  });

  //텍스트 필드 컨트롤러
  final TextEditingController? controller;

  //힌트텍스트
  final String? hintText;

  //hint Color
  final Color? hintColor;

  //onChanged: TextField 칸의 내용이 바로바로 바뀔 때
  final Function(String)? onChanged;

  //onSubmitted: 키보드의 입력완료를 눌렀을 때
  final Function(String)? onSubmitted;

  //테두리 굵기
  final double? outlineWidth;

  //radius
  final double? radius;

  //가로 너비
  final double? width;

  //아이콘
  final Icon? suffixIcon;

  //focusBorder 색
  final Color? focusIconColor;

  //enabledBorder 색
  final Color? enabledIconColor;

  //focusBorder 색
  final Color? focusBorderColor;

  //enabledBorder 색
  final Color? enabledBorderColor;

  //fillColor 색
  final Color? fillColor;

  @override
  State<SFSearchField> createState() => _SFSearchFieldState();
}

class _SFSearchFieldState extends State<SFSearchField> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Color iconColor = _isFocused
        ? widget.focusIconColor ?? SFColor.primary60
        : widget.enabledIconColor ?? SFColor.grayScale20;

    return SizedBox(
      width: widget.width,
      child: TextField(
          controller: widget.controller,
          style: const TextStyle(
            decorationThickness: 0,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: widget.fillColor ?? Colors.white,
            hintText: widget.hintText ?? '검색어를 입력하세요.',
            hintStyle: SFTextStyle.b4R14(
              color: widget.hintColor ?? SFColor.grayScale20,
            ),
            suffixIcon: widget.suffixIcon ??
                Icon(
                  Icons.search,
                  color: iconColor,
                ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: widget.focusBorderColor ?? SFColor.primary30,
                  width: widget.outlineWidth ?? 1,
                ),
                borderRadius:
                    BorderRadius.all(Radius.circular(widget.radius ?? 10))),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: widget.enabledBorderColor ?? SFColor.grayScale20,
                  width: widget.outlineWidth ?? 1,
                ),
                borderRadius:
                    BorderRadius.all(Radius.circular(widget.radius ?? 10))),
          ),
          onChanged: widget.onChanged,
          onSubmitted: widget.onSubmitted,
          focusNode: _focusNode),
    );
  }
}
