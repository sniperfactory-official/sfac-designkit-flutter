import 'package:flutter/material.dart';
import 'package:sfac_design_flutter/sfac_design_flutter.dart';

enum SFButtonStatus {
  primary,
  secondary,
  outline,
  destructive,
  disabled,
  asChild,
  link,
  ghost
}

class SFButton extends StatefulWidget {
  const SFButton({
    super.key,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.outlineColor,
    this.disabledTextColor,
    this.disabledbackgroundColor,
    this.width,
    this.height,
    this.outlineWidth = 1.0,
    this.outlineRadius = 10,
    this.hoverTextStyle,
    this.hoverbackgroundColor,
    this.status = SFButtonStatus.primary,
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

  // 버튼 상태 enum
  final SFButtonStatus status;

  //child 크기만큼의 버튼 크기
  final bool isAsChild;

  @override
  State<SFButton> createState() => _SFButtonState();
}

class _SFButtonState extends State<SFButton> {
  bool _ishover = false;
  bool _isLink = false;
  bool _isAsChild = false;
  Color? _backgroundColor;
  Color? _textColor;
  Color? _outlineColor;
  Color? _hoverBackgroundColor;

  @override
  Widget build(BuildContext context) {
    void Function()? onPressed = widget.onPressed;
    _isAsChild = widget.isAsChild;
    switch (widget.status) {
      case SFButtonStatus.primary:
        _backgroundColor = SFColor.primary80;
        _textColor = Colors.white;
        break;
      case SFButtonStatus.secondary:
        _backgroundColor = SFColor.grayScale5;
        _textColor = SFColor.grayScale60;
        break;
      case SFButtonStatus.outline:
        _outlineColor = SFColor.primary40;
        _backgroundColor = SFColor.primary5;
        _textColor = SFColor.primary60;
        break;
      case SFButtonStatus.destructive:
        _backgroundColor = SFColor.red;
        _textColor = Colors.white;
        break;
      case SFButtonStatus.disabled:
        onPressed = null;
        _backgroundColor = widget.disabledbackgroundColor ?? SFColor.grayScale5;
        _textColor = widget.disabledTextColor ?? SFColor.grayScale20;
        break;
      case SFButtonStatus.asChild:
        _backgroundColor = SFColor.grayScale5;
        _textColor = SFColor.grayScale60;
        _isAsChild = true;
        break;
      case SFButtonStatus.link:
        _backgroundColor = Colors.transparent;
        _textColor = SFColor.primary60;
        _isLink = true;
        break;
      case SFButtonStatus.ghost:
        _backgroundColor = Colors.transparent;
        _textColor = SFColor.primary60;
        _hoverBackgroundColor = SFColor.primary5;
        break;
    }

    Widget? childText;
    TextStyle? childStyle;
    if (widget.child != null) {
      childStyle = _ishover && _isLink
          ? widget.hoverTextStyle ??
              TextStyle(
                  decoration: TextDecoration.underline,
                  decorationThickness: 1.5,
                  fontFamily: 'PretendardBold',
                  fontSize: 16,
                  color: widget.textColor ?? _textColor)
          : SFTextStyle.b3B16(color: widget.textColor ?? _textColor!);
      childText = AnimatedDefaultTextStyle(
        style: childStyle,
        duration: kThemeChangeDuration,
        child: widget.child!,
      );
    }
    return FittedBox(
      child: InkWell(
        onTap: onPressed,
        onHover: (value) {
          _ishover = value;
          setState(() {});
        },
        borderRadius: BorderRadius.all(
          Radius.circular(widget.outlineRadius),
        ),
        hoverColor: widget.hoverbackgroundColor ??
            _hoverBackgroundColor ??
            Colors.transparent,
        child: Ink(
          width: _isAsChild
              ? null
              : widget.width ?? MediaQuery.of(context).size.width,
          height: _isAsChild ? null : widget.height ?? 50,
          decoration: BoxDecoration(
            color: widget.backgroundColor ?? _backgroundColor,
            borderRadius: BorderRadius.circular(widget.outlineRadius),
            border: Border.all(
              color: widget.outlineColor ?? _outlineColor ?? Colors.transparent,
              width: widget.outlineWidth,
            ),
          ),
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(_isAsChild
                  ? widget.isAsChild
                      ? 0
                      : 10
                  : 0),
              child: childText,
            ),
          ),
        ),
      ),
    );
  }
}
