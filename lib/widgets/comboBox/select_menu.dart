import 'package:flutter/material.dart';
import 'package:sfac_design_flutter/sfac_design_flutter.dart';
import 'package:sfac_design_flutter/widgets/comboBox/select_sub.dart';

class SFSelectMenu extends StatelessWidget {
  const SFSelectMenu({
    super.key,
    this.icon,
    required this.text,
    this.selectSub,
    this.spacing = 20,
    this.leadingSpacing = 20,
    this.textStyle,
  });

  // 메뉴 아이콘
  final Icon? icon;

  // 메뉴 텍스트
  final String text;

  // 서브 메뉴 
  final SFSelectSub? selectSub;

  // 아이콘 텍스트 사이 간격
  final double spacing;

  // 아이콘 앞 공백
  final double leadingSpacing;

  // 메뉴 텍스트 스타일
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(width: icon == null ? 0 : leadingSpacing),
        icon ?? const SizedBox(),
        SizedBox(width: spacing),
        DefaultTextStyle(
          style: textStyle ?? SFTextStyle.b3R16(),
          child: Text(text),
        ),
      ],
    );
  }
}
