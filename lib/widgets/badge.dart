import 'package:flutter/material.dart';
import 'package:sfac_designkit_flutter/util/sfac_text_style.dart';
import 'package:sfac_designkit_flutter/util/sfac_color.dart';

class SfBadge extends StatelessWidget {
  const SfBadge({
    super.key,
    this.child,
    this.backgroundColor,
    this.outlineColor,
    this.borderRadius = 4,
    this.width,
    this.height,
    this.margin,
  });
  final Widget? child;
  final Color? backgroundColor;
  final Color? outlineColor;
  final double borderRadius;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    Widget? childText;
    TextStyle? childStyle;
    if (child != null) {
      childStyle = SfacTextStyle.b5R12(color: SfacColor.grayScale60);
      childText = AnimatedDefaultTextStyle(
        style: childStyle,
        duration: kThemeChangeDuration,
        child: child!,
      );
    }
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: backgroundColor ?? SfacColor.grayScale5,
          border: Border.all(color: outlineColor ?? SfacColor.grayScale5),
          borderRadius: BorderRadius.circular(borderRadius)),
      child: Padding(
          padding:
              margin ?? const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
          child: childText),
    );
  }
}
