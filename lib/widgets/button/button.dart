import 'package:flutter/material.dart';
import 'package:sfac_design_flutter/sfac_design_flutter.dart';

class SFButton extends StatefulWidget {
  const SFButton({
    super.key,
    this.backgroundColor,
    this.textColor,
    this.outlineColor,
    required this.onPressed,
    this.disabledTextColor,
    this.disabledbackgroundColor,
    this.width,
    this.height,
    this.outlineWidth = 1.0,
    this.outlineRadius = 10,
    this.hoverTextStyle,
    this.hoverbackgroundColor,
    this.isLink = false,
    this.isAsChild = false,
    required this.child,
  });
  // 자식 위젯
  final Widget? child;

  // 배경 색
  final Color? backgroundColor;

  // 텍스트 색
  final Color? textColor;

  // 테두리 색
  final Color? outlineColor;

  // 버튼 함수
  final void Function()? onPressed;

  // 비활성화 텍스트 색
  final Color? disabledTextColor;

  // 비활성화 배경 색
  final Color? disabledbackgroundColor;

  // 버튼 가로 넓이
  final double? width;

  // 버튼 높이
  final double? height;

  // 테두리 두께
  final double outlineWidth;

  // 테두리 곡선
  final double outlineRadius;

  // 호버 텍스트 스타일
  final TextStyle? hoverTextStyle;

  // 호버 배경색
  final Color? hoverbackgroundColor;

  // 링크 버튼(밑줄) true false
  final bool isLink;

  // child 크기에 맞춤 크기
  final bool isAsChild;

  @override
  State<SFButton> createState() => _SFButtonState();
}

class _SFButtonState extends State<SFButton> {
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
                      ? widget.disabledTextColor ?? SFColor.grayScale20
                      : widget.textColor ?? SFColor.primary60)
          : SFTextStyle.b3B16(
              color: widget.onPressed == null
                  ? widget.disabledTextColor ?? SFColor.grayScale20
                  : widget.isLink
                      ? widget.textColor ?? SFColor.primary60
                      : widget.textColor ?? Colors.white);
      childText = AnimatedDefaultTextStyle(
        style: childStyle,
        duration: kThemeChangeDuration,
        child: widget.child!,
      );
    }
    return FittedBox(
      child: InkWell(
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
          width: widget.isAsChild
              ? null
              : widget.width ?? MediaQuery.of(context).size.width,
          height: widget.isAsChild ? null : widget.height ?? 50,
          decoration: BoxDecoration(
            color: widget.isLink
                ? Colors.transparent
                : widget.onPressed == null
                    ? widget.disabledbackgroundColor ?? SFColor.grayScale5
                    : widget.backgroundColor ?? SFColor.primary100,
            borderRadius: BorderRadius.circular(widget.outlineRadius),
            border: Border.all(
              color: widget.outlineColor ?? Colors.transparent,
              width: widget.outlineWidth,
            ),
          ),
          child: Center(
              child: Padding(
            padding: EdgeInsets.all(widget.isAsChild ? 10 : 0),
            child: childText,
          )),
        ),
      ),
    );
  }
}
