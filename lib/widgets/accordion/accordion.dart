import 'package:flutter/material.dart';
import 'package:sfac_design_flutter/sfac_design_flutter.dart';

class SFAccordion extends StatefulWidget {
  const SFAccordion({
    super.key,
    this.width = double.infinity,
    this.height,
    this.iconButton,
    required this.title,
    required this.content,
    this.contentBackgroundColor,
    this.contentRadius = 10,
    this.contentPadding,
    this.contentMargin,
  });
  final double? width; //아코디언 가로 넓이
  final double? height; //아코디언 높이
  final Widget? iconButton; //  아이콘
  final Widget title; // 접었을 때 보이는 텍스트
  final Widget content; // 펼쳤을 때 보이는 텍스트
  final Color? contentBackgroundColor; //펼쳤을 때 보이는 텍스트 상자 배경색
  final double contentRadius; //펼쳤을 때 보이는 텍스트 상자 곡선
  final EdgeInsetsGeometry? contentPadding; //펼쳤을 때 보이는 텍스트 상자 패딩
  final EdgeInsetsGeometry? contentMargin; // 펼쳤을 때 보이는 텍스트 상자 마진

  @override
  State<SFAccordion> createState() => _SFAccordionState();
}

class _SFAccordionState extends State<SFAccordion> {
  bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    Widget? titleText;
    TextStyle? titleStyle;
    titleStyle = SfacTextStyle.b3M16(color: SfacColor.grayScale100);
    titleText = AnimatedDefaultTextStyle(
      style: titleStyle,
      duration: kThemeChangeDuration,
      child: widget.title,
    );
    Widget? contentText;
    TextStyle? contentStyle;
    contentStyle = SfacTextStyle.b3R16(color: SfacColor.grayScale60);
    contentText = AnimatedDefaultTextStyle(
      style: contentStyle,
      duration: kThemeChangeDuration,
      child: widget.content,
    );

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                  onTap: () {
                    isVisible = !isVisible;
                    setState(() {});
                  },
                  child: isVisible
                      ? Transform.rotate(
                          angle: 90 * 3.1415926535 / 180,
                          child:
                              widget.iconButton ?? const Icon(Icons.play_arrow))
                      : widget.iconButton ?? const Icon(Icons.play_arrow)),
              const SizedBox(width: 5),
              Flexible(child: titleText),
            ],
          ),
          isVisible
              ? Container(
                  margin: widget.contentMargin ??
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  padding: widget.contentPadding ?? const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color:
                          widget.contentBackgroundColor ?? SfacColor.grayScale5,
                      borderRadius: BorderRadius.all(
                          Radius.circular(widget.contentRadius))),
                  child: contentText,
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
