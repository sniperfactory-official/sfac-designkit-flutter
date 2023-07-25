import 'package:flutter/material.dart';
import 'package:sfac_design_flutter/sfac_design_flutter.dart';

class SFNavigationMenu extends StatefulWidget {
  const SFNavigationMenu({
    Key? key,
    required this.menu,
    this.width,
    required this.height,
    this.menuSize,
    this.menuSpacing = 5,
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
    this.initialIndex = 0,
  })  : assert(initialIndex <= menu.length && initialIndex >= 0),
        super(key: key);
  // 리스트 메뉴
  final List<String> menu;

  // 가로 넓이
  final double? width;

  // 높이
  final double height;

  // 메뉴 가로 크기
  final double? menuSize;

  // 메뉴 사이 spacing
  final double? menuSpacing;

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
  final int initialIndex;

  @override
  State<SFNavigationMenu> createState() => _SFNavigationMenu();
}

class _SFNavigationMenu extends State<SFNavigationMenu> {
  int? focusedChild;
  List<bool> ishover = [];
  double? widthSpacing;
  double? heightSpacing;
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
      height: widget.height,
      child: ListView.separated(
        physics: widget.physics ?? const NeverScrollableScrollPhysics(),
        scrollDirection: widget.direction,
        itemCount: widget.menu.length,
        itemBuilder: (context, index) => InkWell(
          splashColor: Colors.transparent, // 클릭할 때 나오는 효과 색상
          highlightColor: Colors.transparent, // 클릭 유지 시 나오는 효과 색상
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
                style: SFTextStyle.b3M16(
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
    );
  }

  spacing() {
    switch (widget.direction) {
      case Axis.vertical:
        heightSpacing = widget.menuSpacing;
        break;
      case Axis.horizontal:
        widthSpacing = widget.menuSpacing;
        break;
    }
  }
}
