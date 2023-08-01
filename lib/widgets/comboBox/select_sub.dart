import 'package:flutter/material.dart';
import 'package:sfac_design_flutter/sfac_design_flutter.dart';

class SFSelectSub extends StatefulWidget {
  const SFSelectSub({
    super.key,
    required this.menu,
    this.width,
    this.height,
    this.focusedColor,
    this.textColor,
    this.direction = Axis.vertical,
    this.onTap,
    this.spacing = 14,
    this.physics,
    this.initialIndex,
    this.textStyle,
  });

  // 셀렉트 메뉴 리스트
  final List<String> menu;

  // 셀렉트 메뉴 가로 너비
  final double? width;

  // 셀렉트 메뉴 높이
  final double? height;

  // 포커스된 메뉴 컬러
  final Color? focusedColor;

  // 메뉴 텍스트 컬러
  final Color? textColor;

  // 셀렉트 메뉴 정렬 방향
  final Axis direction;

  // 메뉴 클릭 함수 클릭한 index 값 return
  final Function(int)? onTap;

  // 메뉴 사이 간격
  final double spacing;

  // 셀렉트 메뉴 ScrollPhysics
  final ScrollPhysics? physics;

  // 시작 인덱스
  final int? initialIndex;

  // 서브 메뉴 텍스트 스타일
  final TextStyle? textStyle;

  @override
  State<SFSelectSub> createState() => _SelectedSubState();
}

class _SelectedSubState extends State<SFSelectSub> {
  int? _focusedIndex;
  List<bool> _ishover = [];
  @override
  void initState() {
    super.initState();
    _ishover = List.generate(widget.menu.length, (index) => false);
    _focusedIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height ??
          widget.menu.length *
              ((widget.textStyle != null
                      ? (widget.textStyle!.fontSize ?? 14) + 1
                      : 15) +
                  (widget.spacing + 1) +
                  3),
      child: ListView.separated(
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
            _focusedIndex = index;
            setState(() {});
          },
          onHover: (value) {
            _ishover[index] = value;
            setState(() {});
          },
          hoverColor: Colors.transparent,
          child: Text(
            widget.menu[index],
            style: widget.textStyle ??
                SFTextStyle.b4R14(
                    color: _ishover[index]
                        ? widget.focusedColor ?? SFColor.primary80
                        : _focusedIndex == index
                            ? widget.focusedColor ?? SFColor.primary80
                            : widget.textColor ?? Colors.black),
          ),
        ),
        separatorBuilder: (context, index) => SizedBox(
          width: widget.spacing,
          height: widget.spacing,
        ),
      ),
    );
  }
}
