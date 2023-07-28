import 'package:flutter/material.dart';
import 'package:sfac_design_flutter/sfac_design_flutter.dart';
import 'package:sfac_design_flutter/widgets/comboBox/select_group.dart';
import 'package:sfac_design_flutter/widgets/comboBox/select_main.dart';

enum SFComboBoxnStatus {
  select,
  searchSelect, //multiSelect 추후 추가 예정
}

class SFComboBox extends StatefulWidget {
  const SFComboBox({
    Key? key,
    this.status = SFComboBoxnStatus.select,
    required this.selectMain,
    this.hintText,
    this.padding = 10,
    this.outlineColor,
    this.outlineWidth = 1.0,
    this.outlineRadius = 10,
    this.width,
    this.height,
    this.trailingIcon,
    this.onTap,
    this.boxScorllPhysics,
    this.backgroundColor,
    this.focusedBackgroundColor,
  }) : super(key: key);

  // 콤보박스 상태
  final SFComboBoxnStatus status;

  // 메뉴 선택 전 텍스트
  final String? hintText;

  // 셀렉트 메뉴 타입의 셀렉트 메뉴 리스트
  final List<SFSelectMain> selectMain;

  // 메뉴 패딩
  final double padding;

  // 콤보 박스 테두리 색
  final Color? outlineColor;

  // 콤보 박스 테두리 굵기
  final double outlineWidth;

  // 콤보 박스 테두리 곡선
  final double outlineRadius;

  // 콤보박스 가로 넓이
  final double? width;

  // 콤보박스 펼친 박스 높이
  final double? height;

  // 콤보박스 펼치기 전 박스 trailing icon
  final Widget? trailingIcon;

  // 메뉴 클릭 함수 클릭한 index 값 return
  final Function(int)? onTap;

  // 콤보박스 펼친 박스 ScrollPhysics
  final ScrollPhysics? boxScorllPhysics;

  // 콤보 박스 전체 배경색
  final Color? backgroundColor;

  // 포커스 또는 hover 된 메뉴 배경색
  final Color? focusedBackgroundColor;

  @override
  State<SFComboBox> createState() => _SFComboBoxState();
}

class _SFComboBoxState extends State<SFComboBox> {
  bool isTap = false;
  String hintText = '';
  Widget? icon;
  int initialndex = 0;
  List<SFSelectMain> selectMain = [];
  bool isDropdownVisible = false;
  bool isInput = false;

  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  Size? size;
  final GlobalKey _buttonKey = GlobalKey();

  void createOverlayEntry() {
    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          GestureDetector(
            onTap: () {
              hideDropdown();
              isDropdownVisible = false;
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
              offset: Offset(0, size!.height),
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
                  child: SFSelectGroup(
                    downDuration: isDropdownVisible
                        ? null
                        : const Duration(milliseconds: 300),
                    direction: Axis.vertical,
                    height: widget.height,
                    selectMain: selectMain,
                    initialndex: initialndex,
                    physics: widget.boxScorllPhysics,
                    selectedMenuText: widget.selectMain[initialndex].text,
                    focusedBackgroundColor: widget.focusedBackgroundColor,
                    onTap: (index) {
                      if (widget.onTap != null) {
                        widget.onTap!(index);
                      }
                      textEditingController.text = selectMain[index].text;
                      hintText = selectMain[index].text;
                      icon = selectMain[index].icon;
                      initialndex = index;
                      if (_overlayEntry != null) {
                        hideDropdown();
                      }
                      isDropdownVisible = false;
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
        size = _getSize();
      });
    });
    selectMain = widget.selectMain;
  }

  filterMenu(String value) {
    if (value.isNotEmpty) {
      setState(() {
        selectMain =
            widget.selectMain.where((e) => e.text.contains(value)).toList();
      });
    } else {
      setState(() {
        selectMain = widget.selectMain;
      });
    }
  }

  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: CompositedTransformTarget(
        link: _layerLink,
        child: TextField(
          key: _buttonKey,
          readOnly:
              widget.status == SFComboBoxnStatus.searchSelect ? false : true,
          onTap: () async {
            showDropdown();
            await Future.delayed(const Duration(milliseconds: 300));
            isDropdownVisible = true;
          },
          controller: textEditingController,
          onChanged: (value) {
            filterMenu(value);
            toggleDropdown();
            toggleDropdown();
          },
          onSubmitted: (value) {
            textEditingController.text = widget.selectMain
                .where((e) => e.text.contains(value))
                .toList()
                .first
                .text;
            hideDropdown();
            isDropdownVisible = false;
            for (int i = 0; i < widget.selectMain.length; i++) {
              if (widget.selectMain[i].text == textEditingController.text) {
                initialndex = i;
                if (widget.onTap != null) {
                  widget.onTap!(i);
                }
              }
            }
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: widget.backgroundColor ?? Colors.white,
            hintText: widget.hintText ?? 'Select framework',
            hintStyle: SFTextStyle.b3R16(color: SFColor.grayScale40),
            suffixIcon: Transform.rotate(
              angle: 90 * 3.1415926535 / 180,
              child: widget.trailingIcon ??
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
    );
  }
}
