import 'package:flutter/material.dart';
import 'package:sfac_design_flutter/sfac_design_flutter.dart';
import 'package:sfac_design_flutter/widgets/select/select_main.dart';
import 'package:sfac_design_flutter/widgets/select/select_menu.dart';

enum SFComboBoxStatus {
  select,
  searchSelect, //multiSelect 추후 추가 예정
}

class SFComboBox extends StatefulWidget {
  const SFComboBox({
    Key? key,
    this.status = SFComboBoxStatus.select,
    required this.menus,
    this.hintText,
    this.padding = 10,
    this.outlineColor,
    this.outlineWidth = 1.0,
    this.outlineRadius = 10,
    this.width,
    this.height,
    this.suffixIcon,
    this.onTap,
    this.scrollPhysics,
    this.backgroundColor,
    this.menuBackgroundColor,
    this.focusedBackgroundColor,
    this.menuHeight = 40,
    this.spacing = 10,
  }) : super(key: key);

  // 콤보박스 상태
  final SFComboBoxStatus status;

  // 메뉴 선택 전 텍스트
  final String? hintText;

  // 셀렉트 메뉴 타입의 셀렉트 메뉴 리스트
  final List<SFSelectMenu> menus;

  // 메뉴 패딩
  final double padding;

  // 콤보 박스 테두리 색
  final Color? outlineColor;

  // 콤보 박스 테두리 굵기
  final double outlineWidth;

  // 콤보 박스 테두리 곡선
  final double outlineRadius;

  // 콤보박스 가로 너비
  final double? width;

  // 콤보박스 펼친 박스 높이
  final double? height;

  // 콤보박스 펼치기 전 박스 trailing icon
  final Widget? suffixIcon;

  // 메뉴 클릭 함수 클릭한 index 값 return
  final Function(int)? onTap;

  // 콤보박스 펼친 박스 ScrollPhysics
  final ScrollPhysics? scrollPhysics;

  // 콤보 박스 전체 배경색
  final Color? backgroundColor;

  // 메뉴 배경 색
  final Color? menuBackgroundColor;

  // 포커스 또는 hover 된 메뉴 배경색
  final Color? focusedBackgroundColor;

  // 메뉴 하나의 높이
  final double menuHeight;

  // 메뉴 간격
  final double spacing;

  @override
  State<SFComboBox> createState() => _SFComboBoxState();
}

class _SFComboBoxState extends State<SFComboBox> {
  int? _initialIndex;
  List<SFSelectMenu> _selectMain = [];
  bool _isDropdownVisible = false;

  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  final GlobalKey _buttonKey = GlobalKey();
  double? _widgetTopPosition;
  double? _widgetBottomPosition;
  double? _widgetWidth;
  double? _widgetHeight;
  double? _menuBoxheight;
  double _startPosition = 0.0;

  void createOverlayEntry() {
    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          GestureDetector(
            onTap: () {
              hideDropdown();
              _isDropdownVisible = false;
              FocusScope.of(context).unfocus();
            },
            child: Container(
              color: Colors.transparent,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Positioned(
            width: widget.width ?? _widgetWidth,
            child: CompositedTransformFollower(
              link: _layerLink,
              offset: Offset(0, _startPosition + 4),
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: widget.width ?? _widgetWidth,
                  padding: EdgeInsets.all(widget.padding),
                  decoration: BoxDecoration(
                    color: widget.backgroundColor ?? Colors.white,
                    borderRadius: BorderRadius.circular(widget.outlineRadius),
                    border: Border.all(
                      color: widget.outlineColor ?? SFColor.grayScale20,
                      width: widget.outlineWidth,
                    ),
                  ),
                  child: SFSelectMain(
                    spacing: widget.spacing,
                    menuHeight: widget.menuHeight,
                    menuBackgroundColor: widget.menuBackgroundColor,
                    downDuration: _isDropdownVisible
                        ? null
                        : const Duration(milliseconds: 300),
                    direction: Axis.vertical,
                    width: widget.width ?? _widgetWidth,
                    height: widget.height ?? _menuBoxheight,
                    menus: _selectMain,
                    initialIndex: _initialIndex,
                    physics: widget.scrollPhysics,
                    selectedMenuText: _initialIndex != null
                        ? widget.menus[_initialIndex!].title
                        : null,
                    focusedBackgroundColor: widget.focusedBackgroundColor,
                    onTap: (index) {
                      textEditingController.text = _selectMain[index].title;
                      _initialIndex = widget.menus.indexWhere((element) =>
                          element.title == _selectMain[index].title);
                      if (widget.onTap != null) {
                        widget.onTap!(_initialIndex!);
                      }
                      if (_overlayEntry != null) {
                        hideDropdown();
                      }
                      _isDropdownVisible = false;
                      FocusScope.of(context).unfocus();
                      setState(() {});
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showDropdown() {
    _overlayEntry = null;
    createOverlayEntry();
    Overlay.of(context, rootOverlay: true).insert(_overlayEntry!);
  }

  void hideDropdown() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void toggleDropdown() {
    if (_overlayEntry == null) {
      showDropdown();
    } else {
      hideDropdown();
    }
  }

  _getSize() {
    if (_buttonKey.currentContext != null) {
      final RenderBox renderBox =
          _buttonKey.currentContext!.findRenderObject() as RenderBox;
      Offset widgetPosition = renderBox.localToGlobal(Offset.zero);
      _widgetTopPosition = widgetPosition.dy;
      Offset widgetBottomPosition = renderBox.localToGlobal(Offset.zero) +
          Offset(0, renderBox.size.height);
      _widgetBottomPosition =
          MediaQuery.of(context).size.height - widgetBottomPosition.dy;
      _widgetHeight = renderBox.size.height;
      _widgetWidth = renderBox.size.width;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _getSize();
        getHeight();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _selectMain = widget.menus;
    _menuBoxheight = widget.height ??
        (_selectMain.length * widget.menuHeight +
            (_selectMain.length > 1 ? _selectMain.length - 1 : 0) *
                (widget.spacing));
  }

  getHeight() {
    //메뉴 박스 높이
    _menuBoxheight = widget.height ??
        (_selectMain.length * widget.menuHeight +
            (_selectMain.length > 1 ? _selectMain.length - 1 : 0) *
                (widget.spacing));

    //바텀에서 드롭박스 바텀까지의 높이
    _widgetBottomPosition = _widgetBottomPosition ?? 0;

    //Top에서 드롭박스 탑까지의 높이
    _widgetTopPosition = _widgetTopPosition ?? 0;

    //드롭박스 다운 시작 포지션
    _startPosition = _widgetHeight ?? 0;

    //메뉴가 가지는 높이가 드롭박스 밑으로 내릴 수 있는 높이보다 작을 때
    if (_menuBoxheight! < _widgetBottomPosition!) {
      //드롭박스 밑으로 쭉
    }
    // 드롭박스가 밑으로 내릴 수 있는 높이가 각 메뉴의 높이 + 패딩 2배값 보다 작을 떄
    else if (widget.menus.length > 1 &&
        _widgetBottomPosition! < (widget.menuHeight + widget.padding * 2)) {
      //드롭박스를 위로 배치
      if (_menuBoxheight! > _widgetTopPosition!) {
        //메뉴 높이가 Top에서 드롭박스 탑까지의 높이보다 클 때
        _menuBoxheight = _widgetTopPosition! * 0.8 - 8;
      }
      _startPosition = -_menuBoxheight! - widget.padding * 2 - 8;
    }
    //메뉴가 가지는 높이가 밑으로 내릴 수 있는 높이보다 클 때
    else if (_widgetBottomPosition! < _menuBoxheight!) {
      // 메뉴의 높이를 줄인다
      // 화면 높이에서 드롭박스 바텀까지의 높이만큼 뺀 높이의 0.75배
      _menuBoxheight = _widgetBottomPosition! * 0.75;
    }
  }

  filterMenu(String value) {
    if (value.isNotEmpty) {
      _selectMain = widget.menus.where((e) => e.title.contains(value)).toList();
    } else {
      _selectMain = widget.menus;
    }
    getHeight();
    setState(() {});
  }

  void popOverlay() {
    if (_overlayEntry != null) {
      hideDropdown();
      _isDropdownVisible = false;
      FocusScope.of(context).unfocus();
    }
  }

  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        popOverlay();
        return true;
      },
      child: SizedBox(
        width: widget.width,
        child: CompositedTransformTarget(
          link: _layerLink,
          child: TextField(
            key: _buttonKey,
            readOnly:
                widget.status == SFComboBoxStatus.searchSelect ? false : true,
            onTap: () async {
              showDropdown();
              await Future.delayed(const Duration(milliseconds: 300));
              _isDropdownVisible = true;
            },
            controller: textEditingController,
            onChanged: (value) {
              filterMenu(value);
              toggleDropdown();
              toggleDropdown();
            },
            onSubmitted: (value) {
              textEditingController.text = widget.menus
                  .where((e) => e.title.contains(value))
                  .toList()
                  .first
                  .title;
              hideDropdown();
              _isDropdownVisible = false;
              for (int i = 0; i < widget.menus.length; i++) {
                if (widget.menus[i].title == textEditingController.text) {
                  _initialIndex = i;
                  if (widget.onTap != null) {
                    widget.onTap!(i);
                  }
                }
              }
              FocusScope.of(context).unfocus();
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: widget.backgroundColor ?? Colors.white,
              hintText: widget.hintText ?? 'Select framework',
              hintStyle: SFTextStyle.b3R16(color: SFColor.grayScale40),
              suffixIcon: Transform.rotate(
                angle: 90 * 3.1415926535 / 180,
                child: widget.suffixIcon ??
                    const Icon(
                        Icons.navigate_next), // const SFIcon(SFIcon.coverbox),
              ),
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: SFColor.primary30, width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: SFColor.grayScale20),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
            ),
          ),
        ),
      ),
    );
  }
}
