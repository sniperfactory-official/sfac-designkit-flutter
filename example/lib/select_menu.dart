import 'package:flutter/material.dart';
import 'package:sfac_design_flutter/sfac_design_flutter.dart';

class SFSelectMenu extends StatelessWidget {
  const SFSelectMenu(
      {super.key,
      this.icon,
      required this.text,
      this.widthSpacing = 15,
      this.leadingPadding = 20,
      this.menuTextStyle});
  final Widget? icon;
  final String text;
  final double widthSpacing;
  final double leadingPadding;
  final TextStyle? menuTextStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: icon == null ? 0 : leadingPadding),
        icon ?? const SizedBox(),
        SizedBox(width: widthSpacing),
        DefaultTextStyle(
          style: menuTextStyle ?? SFTextStyle.b3R16(),
          child: Text(text),
        ),
      ],
    );
  }
}
