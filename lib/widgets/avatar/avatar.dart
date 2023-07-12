import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SFAvatar extends StatelessWidget {
  const SFAvatar({
    super.key,
    this.child,
    this.borderWidth = 0.5,
    this.padding = 0,
    this.size = 42,
    this.backgroundColor,
    this.borderColor,
  });
  // 자식 위젯
  final Widget? child;

  // 테두리 두께
  final double borderWidth;

  // 패딩
  final double padding;

  // 위젯 크기
  final double? size;

  // 배경 색
  final Color? backgroundColor;

  // 테두리 색
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.grey,
        borderRadius: BorderRadius.circular(999),
        border:
            Border.all(width: borderWidth, color: borderColor ?? Colors.grey),
      ),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: child ?? SvgPicture.asset('assets/svg/logo.svg')),
    );
  }
}
