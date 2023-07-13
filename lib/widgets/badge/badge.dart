import 'package:flutter/material.dart';
import 'package:sfac_design_flutter/sfac_design_flutter.dart';

class SFBadge extends StatelessWidget {
  const SFBadge({
    super.key,
    required this.child,
    this.backgroundColor,
    this.outlineColor,
    this.borderRadius = 4,
    this.width,
    this.height,
    this.margin,
  });

  //Badge안에 위젯
  final Widget child;

  //Badge배경색
  final Color? backgroundColor;

  //Badge테두리 색
  final Color? outlineColor;

  //Badge모서리 곡선
  final double borderRadius;

  //Badge 가로 너비
  final double? width;

  //Badge 세로 너비
  final double? height;

  //Badge안에 위젯 마진
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    Widget? childText;
    TextStyle? childStyle;
      childStyle = SFTextStyle.b5R12(color: Colors.white);
      childText = AnimatedDefaultTextStyle(
        style: childStyle,
        duration: kThemeChangeDuration,
        child: child,
      );
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: backgroundColor ?? SFColor.primary80,
          border: Border.all(color: outlineColor ?? Colors.transparent),
          borderRadius: BorderRadius.circular(borderRadius)),
      child: Padding(
          padding:
              margin ?? const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
          child: childText),
    );
  }
}