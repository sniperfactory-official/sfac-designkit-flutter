import 'package:flutter/material.dart';
import 'package:sfac_design_flutter/sfac_design_flutter.dart';

class SFTabBar extends StatefulWidget {
  const SFTabBar(
      {super.key,
      required this.menu,
      this.focusedColor,
      this.width,
      required this.height,
      this.backgroundColor,
      this.borderColor,
      this.borderBottom,
      this.borderWidth = 4.0,
      this.onTap,
      this.physics,
      this.menuTextStyle,
      required this.pageController,
      this.duration,
      this.curve});
  //메뉴
  final List<Widget> menu;

  //포커스될 때 색
  final Color? focusedColor;

  //가로 넓이
  final double? width;

  //높이
  final double height;

  // 탭 배경색
  final Color? backgroundColor;

  //탭 테두리색
  final Color? borderColor;

  // 바텀보더
  final BorderSide? borderBottom;

  //보더 테두리 두께
  final double borderWidth;

  // 탭 인덱스 리콜함수
  final Function(int)? onTap;

  // 스크롤 피지컬
  final ScrollPhysics? physics;

  // 메뉴 텍스트 스타일
  final TextStyle? menuTextStyle;

  // 페이지 컨트롤러
  final TabController pageController;

  // 페이지 이동 시간
  final Duration? duration;

  // 페이지 이동 효과
  final Curve? curve;

  @override
  State<SFTabBar> createState() => _TabState();
}

class _TabState extends State<SFTabBar> {
  int initialPage = 0;
  List<bool> isHover = [];

  @override
  void initState() {
    super.initState();
    isHover = List.generate(widget.menu.length, (index) => false);
    // initialPage = widget.pageController.initialPage;
  }

  @override
  Widget build(BuildContext context) {
    widget.pageController.addListener(_pageListener);
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
              SFTextStyle.b3M16(
                color: initialPage == index
                    ? widget.focusedColor ?? SFColor.primary100
                    : Colors.black,
              );
          menuText = AnimatedDefaultTextStyle(
            style: menuStyle,
            duration: kThemeChangeDuration,
            child: widget.menu[index],
          );
          return InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              if (widget.onTap != null) {
                widget.onTap!(index);
              }
              widget.pageController.animateTo(
                index,
                duration: widget.duration ?? const Duration(milliseconds: 500),
                curve: widget.curve ?? Curves.ease,
              );
            },
            hoverColor: Colors.transparent,
            onHover: (value) {
              setState(() {
                isHover[index] = value;
              });
            },
            child: Container(
              width: widget.width != null
                  ? widget.width! / widget.menu.length
                  : MediaQuery.of(context).size.width / widget.menu.length,
              decoration: BoxDecoration(
                color: widget.backgroundColor,
                border: Border(
                  bottom: isHover[index]
                      ? widget.borderBottom ??
                          BorderSide(
                            color: widget.borderColor ?? SFColor.primary100,
                            width: widget.borderWidth,
                          )
                      : initialPage == index
                          ? widget.borderBottom ??
                              BorderSide(
                                color: widget.borderColor ?? SFColor.primary100,
                                width: widget.borderWidth,
                              )
                          : BorderSide.none,
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    isHover[index]
                        ? SizedBox(
                            height: widget.borderBottom != null ||
                                    widget.borderBottom != BorderSide.none
                                ? widget.borderWidth
                                : null,
                          )
                        : initialPage != index
                            ? const SizedBox()
                            : SizedBox(
                                height: widget.borderBottom != null ||
                                        widget.borderBottom != BorderSide.none
                                    ? widget.borderWidth
                                    : null,
                              ),
                    menuText,
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _pageListener() {
    if (initialPage != widget.pageController.index.round()) {
      setState(() {
        initialPage = widget.pageController.index.round();
        print('object');
      });
    }
  }

  @override
  void dispose() {
    widget.pageController.removeListener(_pageListener);
    super.dispose();
  }
}
