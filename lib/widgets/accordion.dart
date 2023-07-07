import 'package:flutter/material.dart';
import 'package:sfac_designkit_flutter/util/sfac_text_style.dart';
import 'package:sfac_designkit_flutter/util/sfac_color.dart';

class SfAccordion extends StatefulWidget {
  const SfAccordion({
    super.key,
    this.defaultIcon,
    this.selectedIcon,
    this.title,
    this.content,
    this.contentBackgroundColor,
    this.contentRadius = 10,
    this.contentPadding,
    this.contentMargin,
  });
  final Widget? defaultIcon; // 접었을 때 기본적인 아이콘
  final Widget? selectedIcon; // 펼쳤을 때 아이콘
  final Widget? title; // 접었을 때 보이는 텍스트
  final Widget? content; // 펼쳤을 때 보이는 텍스트
  final Color? contentBackgroundColor; //펼쳤을 때 보이는 텍스트 상자 배경색
  final double contentRadius; //펼쳤을 때 보이는 텍스트 상자 곡선
  final EdgeInsetsGeometry? contentPadding; //펼쳤을 때 보이는 텍스트 상자 패딩
  final EdgeInsetsGeometry? contentMargin; // 펼쳤을 때 보이는 텍스트 상자 마진

  @override
  State<SfAccordion> createState() => _SfAccordionState();
}

class _SfAccordionState extends State<SfAccordion> {
  bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    Widget? titleText;
    TextStyle? titleStyle;
    if (widget.title != null) {
      titleStyle = SfacTextStyle.b3M16(color: SfacColor.grayScale100);
      titleText = AnimatedDefaultTextStyle(
        style: titleStyle,
        duration: kThemeChangeDuration,
        child: widget.title!,
      );
    }
    Widget? contentText;
    TextStyle? contentStyle;
    if (widget.content != null) {
      contentStyle = SfacTextStyle.b3R16(color: SfacColor.grayScale60);
      contentText = AnimatedDefaultTextStyle(
        style: contentStyle,
        duration: kThemeChangeDuration,
        child: widget.content!,
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
                onTap: () {
                  isVisible = !isVisible;
                  setState(() {});
                },
                child: isVisible
                    ? widget.selectedIcon ?? const Icon(Icons.arrow_drop_down)
                    : widget.defaultIcon ?? const Icon(Icons.play_arrow)),
            const SizedBox(width: 5),
            Flexible(child: titleText ?? const SizedBox()),
          ],
        ),
        isVisible
            ? Padding(
                padding: widget.contentPadding ??
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: Container(
                  decoration: BoxDecoration(
                      color:
                          widget.contentBackgroundColor ?? SfacColor.grayScale5,
                      borderRadius: BorderRadius.all(
                          Radius.circular(widget.contentRadius))),
                  child: Padding(
                      padding: widget.contentMargin ?? const EdgeInsets.all(15),
                      child: contentText),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
