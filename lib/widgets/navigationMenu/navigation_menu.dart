import 'package:flutter/material.dart';
import 'package:sfac_design_flutter/sfac_design_flutter.dart';

class SFNavigationMenu extends StatefulWidget {
  const SFNavigationMenu({
    super.key,
    required this.menus,
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
    this.disabledPaddingIndex,
    this.disabledHoverIndex,
  });
  // 리스트 메뉴
  final List<Widget> menus;

  // 가로 너비
  final double? width;

  // 높이
  final double? height;

  // 메뉴 크기
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

  // padding 적용 안 시킬 menu index List
  final List<int>? disabledPaddingIndex;

  // hover효과 적용 안 시킬 menu index List
  final List<int>? disabledHoverIndex;

  @override
  State<SFNavigationMenu> createState() => _SFNavigationMenu();
}

class _SFNavigationMenu extends State<SFNavigationMenu> {
  int? _focusedIndex;
  List<bool> _ishover = [];
  double? _widthSpacing;
  double? _heightSpacing;
  double? _height;
  List<int> _disabledPaddingIndex = [];
  List<int> _disabledHoverIndex = [];

  @override
  void initState() {
    super.initState();
    _ishover = List.generate(widget.menus.length, (index) => false);
    _focusedIndex = widget.initialIndex;
    _disabledPaddingIndex = widget.disabledPaddingIndex ?? [];
    _disabledHoverIndex = widget.disabledHoverIndex ?? [];
    spacing();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height ?? _height,
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: ListView.separated(
          padding: EdgeInsets.zero,
          physics: widget.physics ?? const NeverScrollableScrollPhysics(),
          scrollDirection: widget.direction,
          itemCount: widget.menus.length,
          itemBuilder: (context, index) => InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              if (widget.onTap != null) {
                widget.onTap!(index);
              }
              _focusedIndex = index;
              setState(() {});
            },
            hoverColor: _disabledHoverIndex.contains(index)
                ? Colors.transparent
                : widget.focusedBackgroundColor ?? SFColor.primary5,
            onHover: (value) {
              _ishover[index] = value;
              setState(() {});
            },
            borderRadius: BorderRadius.all(
              Radius.circular(widget.radius),
            ),
            child: Ink(
              width: widget.menuSize,
              height: widget.menuSize,
              padding: widget.padding ??
                  EdgeInsets.all(
                      _disabledPaddingIndex.contains(index) ? 0 : 12.0),
              decoration: BoxDecoration(
                  color: _focusedIndex == index &&
                          !_disabledHoverIndex.contains(index)
                      ? widget.focusedBackgroundColor ?? SFColor.primary5
                      : widget.backgroundColor,
                  border: Border.all(
                      width: widget.outlineWidth ?? 0,
                      color: widget.outlineColor ?? Colors.transparent),
                  borderRadius: BorderRadius.circular(widget.radius)),
              child: Center(
                child: DefaultTextStyle(
                  style: widget.textStyle ??
                      SFTextStyle.b3M16(
                          color: _ishover[index] &&
                                  !_disabledHoverIndex.contains(index)
                              ? widget.focusedTextColor ?? SFColor.primary80
                              : _focusedIndex == index
                                  ? widget.focusedTextColor ?? SFColor.primary80
                                  : widget.textColor ?? Colors.black),
                  child: widget.menus[index],
                ),
              ),
            ),
          ),
          separatorBuilder: (context, index) => SizedBox(
            width: _widthSpacing,
            height: _heightSpacing,
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
        _heightSpacing = widget.menuSpacing;
        _height = (_heightSpacing! + (widget.menuSize ?? fontSize + 26)) *
                widget.menus.length -
            (26 * _disabledPaddingIndex.length);
        break;
      case Axis.horizontal:
        _widthSpacing = widget.menuSpacing;
        _height = fontSize + 26;
        break;
    }
  }
}
