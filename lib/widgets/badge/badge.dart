import 'package:flutter/material.dart';
import 'package:sfac_design_flutter/sfac_design_flutter.dart';

enum SFBadgeStatus { primary, secondary, outline, destructive }

class SFBadge extends StatelessWidget {
  const SFBadge(
      {super.key,
      this.child,
      this.status = SFBadgeStatus.primary,
      this.backgroundColor,
      this.textColor,
      this.border,
      this.borderRadius = 4,
      this.padding});

  //Badge안에 위젯
  final Widget? child;

  //Badge 타입
  final SFBadgeStatus status;

  //Badge모서리 곡선
  final double borderRadius;

  //Badge안에 위젯 padding
  final EdgeInsetsGeometry? padding;

  //Badge color
  final Color? backgroundColor;

  //Badge textStyle
  final Color? textColor;

  //Badge 테두리
  final Border? border;

  @override
  Widget build(BuildContext context) {
    // Badge statusBorder
    Border? statusBorder;

    // statusTextColor
    Color? statusTextColor;

    // statusBackgroundColor
    Color? statusBackgroundColor;

    switch (status) {
      case SFBadgeStatus.primary:
        statusBorder = Border.all(color: Colors.transparent);
        statusBackgroundColor = SFColor.primary80;
        statusTextColor = Colors.white;
        break;
      case SFBadgeStatus.secondary:
        statusBorder = Border.all(color: Colors.transparent);
        statusBackgroundColor = SFColor.grayScale5;
        statusTextColor = SFColor.grayScale60;
        break;
      case SFBadgeStatus.outline:
        statusBorder = Border.all(color: SFColor.primary40);
        statusBackgroundColor = SFColor.primary5;
        statusTextColor = SFColor.primary60;
        break;
      case SFBadgeStatus.destructive:
        statusBorder = Border.all(color: Colors.transparent);
        statusBackgroundColor = SFColor.red;
        statusTextColor = Colors.white;
        break;
    }

    return Container(
      padding:
          padding ?? const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      decoration: BoxDecoration(
          color: backgroundColor ?? statusBackgroundColor,
          border: border ?? statusBorder,
          borderRadius: BorderRadius.circular(borderRadius)),
      child: DefaultTextStyle(
        style: SFTextStyle.b5R12(color: textColor ?? statusTextColor),
        child: child ?? const Text(''),
      ),
    );
  }
}