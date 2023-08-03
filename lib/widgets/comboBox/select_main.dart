import 'package:flutter/material.dart';
import 'package:sfac_design_flutter/sfac_design_flutter.dart';
import 'package:sfac_design_flutter/widgets/comboBox/select_menu.dart';

class SFSelectMain extends StatefulWidget {
  const SFSelectMain({
    super.key,
    required this.menus,
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
    this.menuHeight = 40,
  });

  // SFSelectMenu 타입의 메뉴 리스트
  final List<SFSelectMenu> menus;

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

  // 메뉴 하나의 높이
  final double menuHeight;

  @override
  State<SFSelectMain> createState() => _SFSelectMainState();
}

class _SFSelectMainState extends State<SFSelectMain>
    with TickerProviderStateMixin  {
  List<bool> _isVisibleSub = [];
  late AnimationController _controller;
  late Animation<double> _animation;
  String? _selectedText;
  bool isscrollbars = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    double height = widget.height ??
        (widget.menus.length * widget.menuHeight +
            (widget.menus.length - 1) * widget.spacing);
    if (height > MediaQuery.of(context).size.height * 0.9) {
      height = widget.height ?? MediaQuery.of(context).size.height * 0.8;
      isscrollbars = true;
    }

    _controller = AnimationController(
      duration: widget.downDuration ?? const Duration(milliseconds: 300),
      vsync: this,
    );

    _animation = Tween<double>(
      begin: widget.downDuration != null ? 0.0 : height,
      end: height,
    ).animate(_controller);

    _controller.forward();
  }

  @override
  void initState() {
    super.initState();
    _isVisibleSub = List.generate(widget.menus.length, (index) => false);
    _selectedText = widget.selectedMenuText ??
        (widget.initialIndex != null
            ? widget.menus[widget.initialIndex!].title
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
              behavior: ScrollConfiguration.of(context)
                  .copyWith(scrollbars: isscrollbars),
              child: ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: widget.physics ?? const BouncingScrollPhysics(),
                scrollDirection: widget.direction,
                itemCount: widget.menus.length,
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
                        if (!_isVisibleSub[index]) {
                          _isVisibleSub.fillRange(
                              0, _isVisibleSub.length, false);
                        }
                        _isVisibleSub[index] = !_isVisibleSub[index];
                        _selectedText = widget.menus[index].title;
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
                            color: widget.menus[index].title == _selectedText
                                ? widget.focusedBackgroundColor ??
                                    SFColor.primary5
                                : widget.mainBackgroundColor,
                            border: Border.all(
                                width: widget.outlineWidth ?? 0,
                                color:
                                    widget.outlineColor ?? Colors.transparent),
                            borderRadius: BorderRadius.circular(widget.radius)),
                        child: widget.menus[index],
                      ),
                    ),
                    widget.menus[index].selectSub != null &&
                            _isVisibleSub[index]
                        ? Padding(
                            padding: widget.subPadding ??
                                const EdgeInsets.only(left: 74.0, top: 6.0),
                            child: widget.menus[index].selectSub!,
                          )
                        : const SizedBox()
                  ],
                ),
                separatorBuilder: (context, index) =>
                    SizedBox(height: widget.spacing),
              ),
            ),
          );
        },
      ),
    );
  }
}
