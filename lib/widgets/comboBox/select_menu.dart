import 'package:flutter/material.dart';
import 'package:sfac_design_flutter/sfac_design_flutter.dart';
import 'package:sfac_design_flutter/widgets/comboBox/select_sub.dart';

class SFSelectMenu extends StatelessWidget {
  const SFSelectMenu({
    super.key,
    this.leading,
    required this.title,
    this.selectSub,
    this.spacing = 20,
    this.leadingSpacing = 20,
    this.textStyle,
    this.overflow = TextOverflow.ellipsis,
    this.maxLines = 1,
  });

  // 메뉴 아이콘
  final Widget? leading;

  // 메뉴 제목
  final String title;

  // 서브 메뉴
  final SFSelectSub? selectSub;

  // 아이콘 제목 사이 간격
  final double spacing;

  // 아이콘 앞 공백
  final double leadingSpacing;

  // 메뉴 제목 스타일
  final TextStyle? textStyle;

  // 메뉴 제목 overflow를 TextOverflow로 제어
  final TextOverflow? overflow;

  // 메뉴 제목 maxLines
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(width: leading == null ? 0 : leadingSpacing),
        leading ?? const SizedBox(),
        SizedBox(width: spacing),
        Expanded(
          child: DefaultTextStyle(
            style: textStyle ?? SFTextStyle.b3R16(),
            child: Text(
              title,
              overflow: overflow,
              maxLines: maxLines,
            ),
          ),
        ),
      ],
    );
  }
}
