import 'package:flutter/material.dart';
import 'package:sfac_designkit_flutter/util/sfac_color.dart';
import 'package:sfac_designkit_flutter/util/sfac_text_style.dart';

class SfButton extends StatefulWidget {
  const SfButton({
    super.key,
    this.backgroundColor,
    this.textColor,
    this.outlineColor,
    required this.onPressed,
    this.disabledTextColor,
    this.disabledbackgroundColor,
    this.width,
    this.height = 50,
    this.outlineWidth = 1.0,
    this.outlineRadius = 10,
    this.hoverTextStyle,
    this.hoverbackgroundColor,
    this.isLink = false,
    required this.child,
  });
  final Widget? child; // 자식 위젯
  final Color? backgroundColor; // 배경 색
  final Color? textColor; // 텍스트 색
  final Color? outlineColor; // 테두리 색
  final void Function()? onPressed; // 버튼 함수
  final Color? disabledTextColor; // 비활성화 텍스트 색
  final Color? disabledbackgroundColor; // 비활성화 배경 색
  final double? width; // 버튼 가로 넓이
  final double? height; // 버튼 높이
  final double outlineWidth; // 테두리 두께
  final double outlineRadius; // 테두리 곡선
  final TextStyle? hoverTextStyle; // 호버 텍스트 스타일
  final Color? hoverbackgroundColor; // 호버 배경색
  final bool isLink; // 링크 버튼(밑줄) true false

  @override
  State<SfButton> createState() => _SfButtonState();
}

class _SfButtonState extends State<SfButton> {
  bool ishover = false;
  @override
  Widget build(BuildContext context) {
    Widget? childText;
    TextStyle? childStyle;
    if (widget.child != null) {
      childStyle = ishover && widget.isLink
          ? widget.hoverTextStyle ??
              TextStyle(
                  decoration: TextDecoration.underline,
                  decorationThickness: 1.5,
                  fontFamily: 'PretendardBold',
                  fontSize: 16,
                  color: widget.onPressed == null
                      ? widget.disabledTextColor ?? SfacColor.grayScale20
                      : widget.textColor ?? SfacColor.primary60)
          : SfacTextStyle.b3B16(
              color: widget.onPressed == null
                  ? widget.disabledTextColor ?? SfacColor.grayScale20
                  : widget.isLink
                      ? widget.textColor ?? SfacColor.primary60
                      : widget.textColor ?? Colors.white);
      childText = AnimatedDefaultTextStyle(
        style: childStyle,
        duration: kThemeChangeDuration,
        child: widget.child!,
      );
    }
    return InkWell(
      onTap: widget.onPressed,
      onHover: (value) {
        ishover = value;
        setState(() {});
      },
      borderRadius: BorderRadius.all(
        Radius.circular(widget.outlineRadius),
      ),
      hoverColor: widget.hoverbackgroundColor ?? Colors.transparent,
      child: Ink(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: widget.isLink
              ? Colors.transparent
              : widget.onPressed == null
                  ? widget.disabledbackgroundColor ?? SfacColor.grayScale5
                  : widget.backgroundColor ?? SfacColor.primary100,
          borderRadius: BorderRadius.circular(widget.outlineRadius),
          border: Border.all(
            color: widget.outlineColor ?? Colors.transparent,
            width: widget.outlineWidth,
          ),
        ),
        child: Center(child: childText),
      ),
    );
  }
}
