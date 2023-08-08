import 'package:flutter/material.dart';
import 'package:sfac_design_flutter/sfac_design_flutter.dart';

class SFCard extends StatelessWidget {
  const SFCard({
    super.key,
    this.outlineWidth = 1.0,
    this.outlineRadius = 10,
    this.backgroundColor,
    this.outlineColor,
    this.padding = const EdgeInsets.all(20),
    this.margin,
    this.width,
    this.height,
    this.title,
    this.content,
    this.leading,
    this.trailing,
    this.cardHeader,
    this.cardFooter,
    this.verticalSpacing = 10,
    this.horizontalSpacing = 20,
  });
  final Widget? title; //굵은 텍스트스타일 제목
  final Widget? content; //옅은 텍스트스타일 내용
  final Widget? leading; // 왼쪽 공간 위젯
  final Widget? trailing; // 오른쪽 공간 위젯
  final Widget? cardHeader; // 위쪽 공간 위젯
  final Widget? cardFooter; // 아래쪽 공간 위젯
  final double outlineWidth; // 테두리 두께
  final double outlineRadius; // 테두리 곡선
  final Color? backgroundColor; // 배경색
  final Color? outlineColor; //테두리 색
  final EdgeInsets? margin; // 테두리 밖 여백
  final EdgeInsets padding; // 테두리 안 여백
  final double? width; // 카드 가로 폭
  final double? height; // 카드 세로 폭
  final double verticalSpacing; // 세로 사이사이 공간
  final double horizontalSpacing; // 가로 사이사이 공간

  @override
  Widget build(BuildContext context) {
    Widget? titleText;
    TextStyle? titleStyle;
    if (title != null) {
      titleStyle = SFTextStyle.b3M16(color: SFColor.grayScale100);
      titleText = AnimatedDefaultTextStyle(
        style: titleStyle,
        duration: kThemeChangeDuration,
        child: title!,
      );
    }
    Widget? contentText;
    TextStyle? contentStyle;
    if (content != null) {
      contentStyle = SFTextStyle.b3R16(color: SFColor.grayScale60);
      contentText = AnimatedDefaultTextStyle(
        style: contentStyle,
        duration: kThemeChangeDuration,
        child: content!,
      );
    }
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(outlineRadius),
        border: Border.all(
          color: outlineColor ?? SFColor.grayScale20,
          width: outlineWidth,
        ),
      ),
      child: Container(
        width: width,
        height: height,
        padding: padding,
        margin: margin,
        decoration: BoxDecoration(
          color: backgroundColor,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            leading ?? const SizedBox(),
            SizedBox(width: leading != null ? horizontalSpacing : 0),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  cardHeader ?? const SizedBox(),
                  SizedBox(height: cardHeader != null ? verticalSpacing : 0),
                  titleText ?? const SizedBox(),
                  SizedBox(height: contentText != null ? verticalSpacing : 0),
                  contentText ?? const SizedBox(),
                  SizedBox(height: cardFooter != null ? verticalSpacing : 0),
                  cardFooter ?? const SizedBox(),
                ],
              ),
            ),
            SizedBox(width: trailing != null ? horizontalSpacing : 0),
            trailing ?? const SizedBox(),
          ],
        ),
      ),
    );
  }
}
