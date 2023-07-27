import 'package:flutter/material.dart';
import 'package:sfac_design_flutter/sfac_design_flutter.dart';

class SFSelectSub extends StatefulWidget {
  const SFSelectSub({
    super.key,
    required this.selectMenu,
    this.width,
    required this.height,
    this.focusedColor,
    this.textColor,
    this.direction = Axis.vertical,
    this.onTap,
    this.padding,
    this.menuPadding,
    this.physics,
    this.initialndex,
  });

  // 셀렉트 메뉴 리스트
  final List<String> selectMenu;

  // 셀렉트 메뉴 가로 넓이
  final double? width;

  // 셀렉트 메뉴 높이
  final double height;

  // 포커스된 메뉴 컬러
  final Color? focusedColor;

  // 메뉴 텍스트 컬러
  final Color? textColor;

  // 셀렉트 메뉴 정렬 방향
  final Axis direction;

  // 메뉴 클릭 함수 클릭한 index 값 return
  final Function(int)? onTap;

  // 패딩
  final EdgeInsetsGeometry? padding;

  // 텍스트 패딩
  final EdgeInsetsGeometry? menuPadding;

  // 셀렉트 메뉴 ScrollPhysics
  final ScrollPhysics? physics;

  // 시작 인덱스
  final int? initialndex;

  @override
  State<SFSelectSub> createState() => _SelectedSubState();
}

class _SelectedSubState extends State<SFSelectSub> {
  int? focusedChild;
  List<bool> ishover = [];
  @override
  void initState() {
    super.initState();
    ishover = List.generate(widget.selectMenu.length, (index) => false);
    focusedChild = widget.initialndex;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? const EdgeInsets.only(left: 65.0, top: 8.0),
      child: SizedBox(
        width: widget.width,
        height: widget.height,
        child: ListView.builder(
          physics: widget.physics ?? const NeverScrollableScrollPhysics(),
          scrollDirection: widget.direction,
          itemCount: widget.selectMenu.length,
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
            onHover: (value) {
              ishover[index] = value;
              setState(() {});
            },
            hoverColor: Colors.transparent,
            child: Padding(
              padding: widget.menuPadding ?? const EdgeInsets.all(8.0),
              child: Text(
                widget.selectMenu[index],
                style: SFTextStyle.b4R14(
                    color: ishover[index]
                        ? widget.focusedColor ?? SFColor.primary80
                        : focusedChild == index
                            ? widget.focusedColor ?? SFColor.primary80
                            : widget.textColor ?? Colors.black),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
