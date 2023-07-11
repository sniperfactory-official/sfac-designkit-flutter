import 'package:flutter/material.dart';

class SFAvatar extends StatelessWidget {
  const SFAvatar({
    super.key,
    this.child,
    this.radius,
    this.padding,
    this.size = 35,
  });
  final Widget? child;
  final double? radius;
  final double? padding;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius ?? 100),
        child: Padding(
          padding: EdgeInsets.all(padding ?? 0),
          child: child,
        ),
      ),
    );
  }
}
