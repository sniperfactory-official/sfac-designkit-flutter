import 'package:flutter/material.dart';
import 'package:sfac_design_flutter/sfac_design_flutter.dart';
import 'package:sfac_design_flutter/widgets/comboBox/select_main.dart';
import 'package:sfac_design_flutter/widgets/comboBox/select_sub.dart';

class SFSelect extends StatefulWidget {
  const SFSelect({
    Key? key,
    required this.selectMain,
    this.selectSub,
    this.width,
    required this.height,
    this.menuBackgroundColor,
    this.focusedBackgroundColor,
    this.outlineColor,
    this.radius = 10,
    this.outlineWidth,
    this.direction = Axis.vertical,
    this.onTap,
    this.padding,
    this.physics,
    this.spacing = 10,
    this.initialndex,
    this.downDuration,
    this.backgroundColor,
    this.selectedMenuText,
  })  : assert(selectSub == null || selectSub.length == selectMain.length),
        super(key: key);

  // SFSelectMenu 타입의 메뉴 리스트
  final List<SFSelectMain> selectMain;

  // SFSelectSub 타입의 메뉴의 서브메뉴 리스트
  // 메뉴의 서브메뉴가 없을 경우에는 해당 인덱스에 null를 넣는다
  // 서브메뉴가 null이거나 메뉴와 서브메뉴의 길이가 같아야 한다
  final List<SFSelectSub?>? selectSub;

  // 가로 넓이
  final double? width;

  // 높이
  final double height;

  // 배경 색
  final Color? backgroundColor;

  // 메뉴 배경 색
  final Color? menuBackgroundColor;

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

  // 셀렉트 메뉴 ScrollPhysics
  final ScrollPhysics? physics;

  // 셀렉트 메뉴 사이 높이
  final double spacing;

  // 시작 인덱스
  final int? initialndex;

  // 애니메이션 동작 시간
  final Duration? downDuration;

  // 선택한 메뉴 텍스트
  // selectMain.text와  selectedMenuText이 같으면 선택 포커스된다
  final String? selectedMenuText;

  @override
  State<SFSelect> createState() => _SelectedMainState();
}

class _SelectedMainState extends State<SFSelect>
    with SingleTickerProviderStateMixin {
  List<SFSelectSub?> selectSub = [];
  List<bool> isVisibleSub = [];
  late AnimationController _controller;
  late Animation<double> _animation;
  String? selectedText;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.downDuration ?? const Duration(milliseconds: 300),
      vsync: this,
    );

    _animation = Tween<double>(
      begin: widget.downDuration != null ? 0.0 : widget.height,
      end: widget.height,
    ).animate(_controller);

    _controller.forward();
    isVisibleSub = List.generate(widget.selectMain.length, (index) => false);
    selectSub = widget.selectSub != null
        ? List.generate(
            widget.selectMain.length,
            (index) => index < widget.selectSub!.length
                ? widget.selectSub![index]
                : null,
          )
        : List<SFSelectSub?>.filled(widget.selectMain.length, null);

    selectedText = widget.selectedMenuText ??
        (widget.initialndex != null
            ? widget.selectMain[widget.initialndex!].text
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
                          if (widget.selectSub != null) {
                            if (!isVisibleSub[index]) {
                              isVisibleSub.fillRange(
                                  0, isVisibleSub.length, false);
                            }
                            isVisibleSub[index] = !isVisibleSub[index];
                          }
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
                                      : widget.menuBackgroundColor,
                              border: Border.all(
                                  width: widget.outlineWidth ?? 0,
                                  color: widget.outlineColor ??
                                      Colors.transparent),
                              borderRadius:
                                  BorderRadius.circular(widget.radius)),
                          child: widget.selectMain[index],
                        ),
                      ),
                      selectSub[index] != null && isVisibleSub[index]
                          ? selectSub[index]!
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
