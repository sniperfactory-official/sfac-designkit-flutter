import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SFAvatar extends StatelessWidget {
  const SFAvatar({
    super.key,
    this.image,
    this.imageRadius,
    this.imagePadding,
    this.size = 16,
    this.backgroundColor,
  });
  // image
  final Widget? image;

  // image 테두리 곡선
  final double? imageRadius;

  // image 패딩
  final double? imagePadding;

  // 위젯 크기
  final double? size;

  // 위젯 배경색
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: size,
      backgroundColor: backgroundColor ?? Colors.grey,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(imageRadius ?? 100),
          child: Padding(
            padding: EdgeInsets.all(imagePadding ?? 0),
            child: image ?? SvgPicture.asset('images/logo.svg'),
          )),
    );
  }
}
