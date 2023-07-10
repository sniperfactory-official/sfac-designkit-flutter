import 'package:flutter/material.dart';

import '../util/sfac_color.dart';
import '../util/sfac_text_style.dart';

class SfTab extends StatefulWidget {
  const SfTab(
      {super.key,
      required this.menu,
      this.focusedColor,
      this.width,
      required this.height,
      this.backgroundColor,
      this.borderColor,
      this.borderBottom,
      this.borderWidth = 4.0,
      required this.onTap,
      this.physics,
      this.menuTextStyle});
  final List<Widget?> menu; //메뉴
  final Color? focusedColor; //포커스될 때 색
  final double? width; //가로 넓이
  final double height; //높이
  final Color? backgroundColor; // 탭 배경색
  final Color? borderColor; //탭 테두리색
  final BorderSide? borderBottom; // 바텀보더
  final double borderWidth; //보더 테두리 두께
  final Function(int)? onTap; // 탭 인덱스 리콜함수
  final ScrollPhysics? physics; // 스크롤 피지컬
  final TextStyle? menuTextStyle; //메뉴 텍스트 스타일

  @override
  State<SfTab> createState() => _TabState();
}

class _TabState extends State<SfTab> {
  int focusedText = 0;
  List<bool> ishover = [];

  @override
  void initState() {
    super.initState();
    ishover = List.generate(widget.menu.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: ListView.builder(
        physics: widget.physics ?? const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: widget.menu.length,
        itemBuilder: (context, index) {
          Widget? menuText;
          TextStyle? menuStyle;
          menuStyle = widget.menuTextStyle ??
              SfacTextStyle.b3M16(
                  color: focusedText == index
                      ? widget.focusedColor ?? SfacColor.primary100
                      : Colors.black);
          menuText = AnimatedDefaultTextStyle(
            style: menuStyle,
            duration: kThemeChangeDuration,
            child: widget.menu[index]!,
          );
          return InkWell(
            splashColor: Colors.transparent, // 클릭할 때 나오는 효과 색상
            highlightColor: Colors.transparent, // 클릭 유지 시 나오는 효과 색상
            onTap: () {
              if (widget.onTap != null) {
                widget.onTap!(index);
              }
              focusedText = index;
              setState(() {});
            },
            hoverColor: Colors.transparent,
            onHover: (value) {
              ishover[index] = value;
              setState(() {});
            },
            child: Container(
              width: widget.width != null
                  ? widget.width! / widget.menu.length
                  : MediaQuery.of(context).size.width / widget.menu.length,
              decoration: BoxDecoration(
                  color: widget.backgroundColor,
                  border: Border(
                    bottom: ishover[index]
                        ? widget.borderBottom ??
                            BorderSide(
                                color:
                                    widget.borderColor ?? SfacColor.primary100,
                                width: widget.borderWidth)
                        : focusedText == index
                            ? widget.borderBottom ??
                                BorderSide(
                                    color: widget.borderColor ??
                                        SfacColor.primary100,
                                    width: widget.borderWidth)
                            : BorderSide.none,
                  )),
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ishover[index]
                      ? SizedBox(
                          height: widget.borderBottom != null ||
                                  widget.borderBottom != BorderSide.none
                              ? widget.borderWidth
                              : null,
                        )
                      : focusedText != index
                          ? const SizedBox()
                          : SizedBox(
                              height: widget.borderBottom != null ||
                                      widget.borderBottom != BorderSide.none
                                  ? widget.borderWidth
                                  : null,
                            ),
                  menuText
                ],
              )),
            ),
          );
        },
      ),
    );
  }
}
