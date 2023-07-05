import 'package:flutter/material.dart';
import 'package:sfac_designkit_flutter/util/sfac_color.dart';
import 'package:sfac_designkit_flutter/util/sfac_text_style.dart';

class SfCard extends StatelessWidget {
  const SfCard({
    super.key,
    this.outlineWidth = 1.0,
    this.outlineRadius = 10,
    this.backgroundColor,
    this.outlineColor,
    this.margin = 20,
    this.width,
    this.height,
    this.title,
    this.subtitle,
    this.left,
    this.right,
    this.top,
    this.bottom,
    this.heightSpacing = 10,
    this.widthSpacing = 20,
  });
  final Widget? title;
  final Widget? subtitle;
  final Widget? left;
  final Widget? right;
  final Widget? top;
  final Widget? bottom;
  final double outlineWidth;
  final double outlineRadius;
  final Color? backgroundColor;
  final Color? outlineColor;
  final double margin;
  final double? width;
  final double? height;
  final double heightSpacing;
  final double widthSpacing;

  @override
  Widget build(BuildContext context) {
    Widget? titleText;
    TextStyle? titleStyle;
    if (title != null) {
      titleStyle = SfacTextStyle.b3M16(color: SfacColor.grayScale100);
      titleText = AnimatedDefaultTextStyle(
        style: titleStyle,
        duration: kThemeChangeDuration,
        child: title!,
      );
    }
    Widget? subtitleText;
    TextStyle? subtitleStyle;
    if (subtitle != null) {
      subtitleStyle = SfacTextStyle.b3R16(color: SfacColor.grayScale60);
      subtitleText = AnimatedDefaultTextStyle(
        style: subtitleStyle,
        duration: kThemeChangeDuration,
        child: subtitle!,
      );
    }
    return Container(
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(outlineRadius),
          border: Border.all(
            color: outlineColor ?? SfacColor.grayScale20,
            width: outlineWidth,
          )),
      child: Padding(
        padding: EdgeInsets.all(margin),
        child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: backgroundColor,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                left ?? const SizedBox(),
                SizedBox(width: left != null ? widthSpacing : 0),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      top ?? const SizedBox(),
                      SizedBox(height: titleText != null ? heightSpacing : 0),
                      titleText ?? const SizedBox(),
                      SizedBox(
                          height: subtitleText != null ? heightSpacing : 0),
                      subtitleText ?? const SizedBox(),
                      SizedBox(height: bottom != null ? heightSpacing : 0),
                      bottom ?? const SizedBox(),
                    ],
                  ),
                ),
                SizedBox(width: right != null ? widthSpacing : 0),
                right ?? const SizedBox(),
              ],
            )),
      ),
    );
  }
}
