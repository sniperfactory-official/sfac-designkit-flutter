import 'package:flutter/material.dart';
import 'package:sfac_design_flutter/sfac_design_flutter.dart';
import 'package:sfac_design_flutter/widgets/select/select_menu.dart';

// 이 위젯만 쓸 때에는 height는 menus 높이에 따라 정해진다
// 정해진 height보다 height를 작게 준 경우 스크롤이 기본적으로 가능하다 
// menus에 subs가 있고 menu를 눌러 sub를 열 경우 높이가 늘어난다
class SFSelectMain extends StatefulWidget {
  SFSelectMain({
    Key? key,
    required this.menus,
    this.width,
    this.height,
    this.menuBackgroundColor,
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
  }) : super(key: key) {
    _checkForDuplicates();
  }

  void _checkForDuplicates() {
    final titles = <String>{};
    final duplicateTitles = <String>{};
    for (var menu in menus) {
      if (!titles.add(menu.title)) {
        duplicateTitles.add(menu.title);
      }
    }
    if (duplicateTitles.isNotEmpty) {
      final duplicateMenuTitles = duplicateTitles.join(', ');
      throw FlutterError(
          'Menu titles must be unique. The following titles are duplicated: $duplicateMenuTitles');
    }
  }

  // SFSelectMenu 타입의 메뉴 리스트
  // 메뉴의 title로 포커스되기 때문에 메뉴의 title들은 모두 유니크해야한다
  final List<SFSelectMenu> menus;

  // 가로 너비
  final double? width;

  // 높이
  final double? height;

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
    with TickerProviderStateMixin {
  List<bool> _isVisibleSub = [];
  late AnimationController _controller;
  late Animation<double> _animation;
  String? _selectedText;

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
            height: widget.downDuration != null ? _animation.value : widget.height,
            child: ScrollConfiguration(
              behavior:
                  ScrollConfiguration.of(context).copyWith(scrollbars: true),
              child: Center(
                child: ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: widget.physics ?? const BouncingScrollPhysics(),
                  scrollDirection: widget.direction,
                  itemCount: widget.menus.length,
                  itemBuilder: (context, index) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
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
                          height: widget.menuHeight,
                          padding: widget.padding ?? const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              color: widget.menus[index].title == _selectedText
                                  ? widget.focusedBackgroundColor ??
                                      SFColor.primary5
                                  : widget.menuBackgroundColor,
                              border: Border.all(
                                  width: widget.outlineWidth ?? 0,
                                  color: widget.outlineColor ??
                                      Colors.transparent),
                              borderRadius:
                                  BorderRadius.circular(widget.radius)),
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
            ),
          );
        },
      ),
    );
  }
}
