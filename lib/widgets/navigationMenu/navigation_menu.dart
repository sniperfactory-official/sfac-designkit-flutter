import 'package:flutter/material.dart';
import 'package:sfac_design_flutter/sfac_design_flutter.dart';

class SFNavigationMenu extends StatefulWidget {
  const SFNavigationMenu({
    super.key,
    required this.menu,
    this.width,
    this.height,
    this.menuSize,
    this.menuSpacing = 10,
    this.backgroundColor,
    this.focusedBackgroundColor,
    this.textColor,
    this.focusedTextColor,
    this.outlineColor,
    this.radius = 10,
    this.outlineWidth,
    this.direction = Axis.horizontal,
    this.onTap,
    this.padding,
    this.physics,
    this.initialIndex,
    this.textStyle,
  });
  // 리스트 메뉴
  final List<String> menu;

  // 가로 넓이
  final double? width;

  // 높이
  final double? height;

  // 메뉴 가로 크기
  final double? menuSize;

  // 메뉴 사이 spacing
  final double menuSpacing;

  // 메뉴 배경 색
  final Color? backgroundColor;

  // 포커스된 메뉴 배경 색
  final Color? focusedBackgroundColor;

  // 메뉴 텍스트 색
  final Color? textColor;

  // 포커스된 메뉴 텍스트 색
  final Color? focusedTextColor;

  // 테두리 색
  final Color? outlineColor;

  // 테두리 곡선
  final double radius;

  // 테두리 굵기
  final double? outlineWidth;

  // 메뉴 정렬 방향
  final Axis direction;

  // 메뉴 클릭 함수
  final Function(int)? onTap;

  // 메뉴 패딩
  final EdgeInsetsGeometry? padding;

  // 네비게이션 메뉴 ScrollPhysics
  final ScrollPhysics? physics;

  // 사적 인덱스
  final int? initialIndex;

  // 메뉴 텍스트 스타일
  final TextStyle? textStyle;

  @override
  State<SFNavigationMenu> createState() => _SFNavigationMenu();
}

class _SFNavigationMenu extends State<SFNavigationMenu> {
  int? focusedChild;
  List<bool> ishover = [];
  double? widthSpacing;
  double? heightSpacing;
  double? height;

  @override
  void initState() {
    super.initState();
    ishover = List.generate(widget.menu.length, (index) => false);
    focusedChild = widget.initialIndex;
    spacing();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height ?? height,
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: ListView.separated(
          padding: EdgeInsets.zero,
          physics: widget.physics ?? const NeverScrollableScrollPhysics(),
          scrollDirection: widget.direction,
          itemCount: widget.menu.length,
          itemBuilder: (context, index) => InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              if (widget.onTap != null) {
                widget.onTap!(index);
              }
              focusedChild = index;
              setState(() {});
            },
            hoverColor: widget.focusedBackgroundColor ?? SFColor.primary5,
            onHover: (value) {
              ishover[index] = value;
              setState(() {});
            },
            borderRadius: BorderRadius.all(
              Radius.circular(widget.radius),
            ),
            child: Ink(
              width: widget.menuSize,
              height: widget.menuSize,
              padding: widget.padding ?? const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                  color: focusedChild == index
                      ? widget.focusedBackgroundColor ?? SFColor.primary5
                      : widget.backgroundColor,
                  border: Border.all(
                      width: widget.outlineWidth ?? 0,
                      color: widget.outlineColor ?? Colors.transparent),
                  borderRadius: BorderRadius.circular(widget.radius)),
              child: Center(
                child: Text(
                  widget.menu[index],
                  style: widget.textStyle ??
                      SFTextStyle.b3M16(
                          color: ishover[index]
                              ? widget.focusedTextColor ?? SFColor.primary80
                              : focusedChild == index
                                  ? widget.focusedTextColor ?? SFColor.primary80
                                  : widget.textColor ?? Colors.black),
                ),
              ),
            ),
          ),
          separatorBuilder: (context, index) => SizedBox(
            width: widthSpacing,
            height: heightSpacing,
          ),
        ),
      ),
    );
  }

  spacing() {
    double fontSize =
        (widget.textStyle != null ? widget.textStyle!.fontSize ?? 16 : 16) +
            4.8;
    switch (widget.direction) {
      case Axis.vertical:
        heightSpacing = widget.menuSpacing;
        height = (heightSpacing! + (widget.menuSize ?? fontSize + 26)) *
            widget.menu.length;
        break;
      case Axis.horizontal:
        widthSpacing = widget.menuSpacing;
        height = fontSize + 26;
        break;
    }
  }
}
