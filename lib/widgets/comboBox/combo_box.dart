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
  Size? _size;

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
            width: widget.width,
            child: CompositedTransformFollower(
              link: _layerLink,
              offset: Offset(0, _size!.height),
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: widget.width,
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
                    downDuration: _isDropdownVisible
                        ? null
                        : const Duration(milliseconds: 300),
                    direction: Axis.vertical,
                    width: widget.width,
                    height: widget.height,
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

  Size? _getSize() {
    if (_buttonKey.currentContext != null) {
      final RenderBox renderBox =
          _buttonKey.currentContext!.findRenderObject() as RenderBox;
      Size size = renderBox.size;
      return size;
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _size = _getSize();
      });
    });
    _selectMain = widget.menus;
  }

  filterMenu(String value) {
    if (value.isNotEmpty) {
      setState(() {
        _selectMain =
            widget.menus.where((e) => e.title.contains(value)).toList();
      });
    } else {
      setState(() {
        _selectMain = widget.menus;
      });
    }
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
