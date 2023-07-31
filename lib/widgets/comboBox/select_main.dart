import 'package:flutter/material.dart';
import 'package:sfac_design_flutter/sfac_design_flutter.dart';
import 'package:sfac_design_flutter/widgets/comboBox/select_menu.dart';

class SFSelectMain extends StatefulWidget {
  const SFSelectMain({
    super.key,
    required this.selectMain,
    this.width,
    this.height,
    this.mainBackgroundColor,
    this.focusedBackgroundColor,
    this.outlineColor,
    this.radius = 10,
    this.outlineWidth,
    this.direction = Axis.vertical,
    this.onTap,
    this.padding,
    this.subPadding,
    this.physics,
    this.spacing = 10,
    this.initialIndex,
    this.downDuration,
    this.backgroundColor,
    this.selectedMenuText,
  });

  // SFSelectMenu 타입의 메뉴 리스트
  final List<SFSelectMenu> selectMain;

  // 가로 너비
  final double? width;

  // 높이
  final double? height;

  // 배경 색
  final Color? backgroundColor;

  // 메뉴 배경 색
  final Color? mainBackgroundColor;

  // 포커스된 메뉴 배경 색
  final Color? focusedBackgroundColor;

  // 테두리 색
  final Color? outlineColor;

  // 테두리 곡선
  final double radius;

  // 테두리 굵기
  final double? outlineWidth;

  // 메뉴 정렬 방향
  final Axis direction;

  // 메뉴 클릭 함수 클릭한 index 값 return
  final Function(int)? onTap;

  // 메뉴 패딩
  final EdgeInsetsGeometry? padding;

  // 서브 메뉴 패딩
  final EdgeInsetsGeometry? subPadding;

  // 셀렉트 메뉴 ScrollPhysics
  final ScrollPhysics? physics;

  // 셀렉트 메뉴 사이 높이
  final double spacing;

  // 시작 인덱스
  final int? initialIndex;

  // 애니메이션 동작 시간
  final Duration? downDuration;

  // 선택한 메뉴 텍스트
  // selectMain.text와  selectedMenuText이 같으면 선택 포커스된다
  final String? selectedMenuText;

  @override
  State<SFSelectMain> createState() => _SFSelectMainState();
}

class _SFSelectMainState extends State<SFSelectMain>
    with SingleTickerProviderStateMixin {
  List<bool> isVisibleSub = [];
  late AnimationController _controller;
  late Animation<double> _animation;
  String? selectedText;
  double getSubLengthMax() {
    int subLengthMax = 0;
    for (var main in widget.selectMain) {
      if (main.selectSub != null) {
        int subLength = main.selectSub!.menu.length; // sub의 길이를 계산
        subLengthMax =
            subLength > subLengthMax ? subLength : subLengthMax; // 최대값 갱신
      }
    }
    return subLengthMax * (15 + 15 + 3 + 6);
  }

  @override
  void initState() {
    super.initState();
    double height = widget.height ??
        (widget.selectMain.length * (16 + 1 + 16 + widget.spacing) +
            getSubLengthMax() + 20);
    _controller = AnimationController(
      duration: widget.downDuration ?? const Duration(milliseconds: 300),
      vsync: this,
    );

    _animation = Tween<double>(
      begin: widget.downDuration != null ? 0.0 : height,
      end: height,
    ).animate(_controller);

    _controller.forward();
    isVisibleSub = List.generate(widget.selectMain.length, (index) => false);
    selectedText = widget.selectedMenuText ??
        (widget.initialIndex != null
            ? widget.selectMain[widget.initialIndex!].text
            : null);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: widget.backgroundColor ?? Colors.transparent,
      child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return SizedBox(
              width: widget.width,
              height: _animation.value,
              child: ScrollConfiguration(
                behavior:
                    ScrollConfiguration.of(context).copyWith(scrollbars: false),
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  physics:
                      widget.physics ?? const NeverScrollableScrollPhysics(),
                  scrollDirection: widget.direction,
                  itemCount: widget.selectMain.length,
                  itemBuilder: (context, index) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        onTap: () {
                          if (widget.onTap != null) {
                            widget.onTap!(index);
                          }
                          if (!isVisibleSub[index]) {
                            isVisibleSub.fillRange(
                                0, isVisibleSub.length, false);
                          }
                          isVisibleSub[index] = !isVisibleSub[index];
                          selectedText = widget.selectMain[index].text;
                          setState(() {});
                        },
                        borderRadius: BorderRadius.all(
                          Radius.circular(widget.radius),
                        ),
                        hoverColor:
                            widget.focusedBackgroundColor ?? SFColor.primary5,
                        child: Ink(
                          padding: widget.padding ?? const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              color:
                                  widget.selectMain[index].text == selectedText
                                      ? widget.focusedBackgroundColor ??
                                          SFColor.primary5
                                      : widget.mainBackgroundColor,
                              border: Border.all(
                                  width: widget.outlineWidth ?? 0,
                                  color: widget.outlineColor ??
                                      Colors.transparent),
                              borderRadius:
                                  BorderRadius.circular(widget.radius)),
                          child: widget.selectMain[index],
                        ),
                      ),
                      widget.selectMain[index].selectSub != null &&
                              isVisibleSub[index]
                          ? Padding(
                              padding: widget.subPadding ??
                                  const EdgeInsets.only(left: 74.0, top: 6.0),
                              child: widget.selectMain[index].selectSub!,
                            )
                          : const SizedBox()
                    ],
                  ),
                  separatorBuilder: (context, index) =>
                      SizedBox(height: widget.spacing),
                ),
              ),
            );
          }),
    );
  }
}
