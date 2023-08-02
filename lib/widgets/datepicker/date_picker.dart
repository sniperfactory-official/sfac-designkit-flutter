import 'package:flutter/material.dart';
import 'package:sfac_design_flutter/sfac_design_flutter.dart';
import 'package:sfac_design_flutter/widgets/datepicker/calendar.dart';


class SFDatePicker extends StatefulWidget {
  const SFDatePicker({
    Key? key,
    this.text,
    this.textStyle,
    this.selectTextStyle,
    this.suffixIcon,
    this.status = SFCalendarStatus.range,
    this.theme = SFCalendarTheme.light,
    this.initialDateList,
    this.initialDateRange,
    this.initialDateOne,
    this.backgroundColor,
    this.textColor,
    this.selectedColor = SFColor.primary100,
    this.rangeColor = SFColor.primary100,
    this.selectedTextColor,
    this.borderRadius = const BorderRadius.all(Radius.circular(10)),
    this.contentSize = 16,
    this.verticalSpacing = 12,
    this.horizontalSpacing = 12,
    this.padding,
    this.getSelectedDate,
    this.outlineColor,
    this.outlineWidth = 1,
    this.todayMark = true,
    this.width,
    this.calendarWidth,
    this.calendarHeight,
  })  : assert(
            verticalSpacing >= 0 && horizontalSpacing >= 0 && contentSize > 0),
        super(key: key);
  final String? text;
  final TextStyle? textStyle;
  final TextStyle? selectTextStyle;
  final Icon? suffixIcon;
  final SFCalendarStatus status;
  final SFCalendarTheme theme;
  final List<DateTime>? initialDateList;
  final DateTimeRange? initialDateRange;
  final DateTime? initialDateOne;
  final Color? backgroundColor;
  final Color? textColor;
  final Color selectedColor;
  final Color rangeColor;
  final Color? selectedTextColor;
  final BorderRadius borderRadius;
  final double contentSize;
  final double verticalSpacing;
  final double horizontalSpacing;
  final EdgeInsetsGeometry? padding;
  final GetSelectedDate? getSelectedDate;
  final Color? outlineColor;
  final double outlineWidth;
  final bool todayMark;
  final double? width;
  final double? calendarWidth;
  final double? calendarHeight;

  @override
  State<SFDatePicker> createState() => _SFDatePickerState();
}

class _SFDatePickerState extends State<SFDatePicker> {
  String? _selectDate;
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  final GlobalKey _buttonKey = GlobalKey();
  Size? size;
  final List<DateTime> _selectedDateList = [];
  DateTime? _selectRangeStart;
  DateTime? _selectRangeEnd;
  DateTime? _selectOne;

  void createOverlayEntry() {
    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          GestureDetector(
            onTap: () {
              hideDropdown();
              FocusScope.of(context).unfocus();
            },
            child: Container(
              color: Colors.transparent,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Positioned(
            width: widget.calendarWidth,
            child: CompositedTransformFollower(
              link: _layerLink,
              offset: Offset(0, size!.height),
              child: Material(
                color: Colors.transparent,
                child: Container(
                    width: widget.calendarWidth,
                    decoration: BoxDecoration(
                      color: widget.backgroundColor ?? Colors.white,
                      borderRadius: widget.borderRadius,
                      border: Border.all(
                        color: widget.outlineColor ?? SFColor.grayScale20,
                        width: widget.outlineWidth,
                      ),
                    ),
                    child: SFCalendar(
                      status: widget.status,
                      theme: widget.theme,
                      initialDateList: _selectedDateList,
                      initialDateRange:
                          _selectRangeStart != null && _selectRangeEnd != null
                              ? DateTimeRange(
                                  start: _selectRangeStart!,
                                  end: _selectRangeEnd!)
                              : null,
                      initialDateOne: _selectOne,
                      backgroundColor: widget.backgroundColor,
                      textColor: widget.textColor,
                      selectedColor: widget.selectedColor,
                      rangeColor: widget.rangeColor,
                      selectedTextColor: widget.selectedTextColor,
                      borderRadius: widget.borderRadius,
                      contentSize: widget.contentSize,
                      verticalSpacing: widget.verticalSpacing,
                      horizontalSpacing: widget.horizontalSpacing,
                      width: widget.calendarWidth,
                      height: widget.calendarHeight,
                      padding: widget.padding,
                      getSelectedDate:
                          (start, end, selectedDateList, selectedOne) {
                        if (widget.getSelectedDate != null) {
                          widget.getSelectedDate!(
                              start, end, selectedDateList, selectedOne);
                        }
                        String month;
                        String day;
                        switch (widget.status) {
                          case SFCalendarStatus.list:
                            List<String> dateList = [];
                            if (selectedDateList != null &&
                                selectedDateList.isNotEmpty) {
                              _selectedDateList.clear();
                              _selectedDateList.addAll(selectedDateList);
                              _selectedDateList.sort();
                              for (var date in _selectedDateList) {
                                month = date.month.toString().padLeft(2, '0');
                                day = date.day.toString().padLeft(2, '0');
                                dateList.add('${date.year}.$month.$day');
                              }
                              _selectDate = dateList.join(', ').toString();
                            } else {
                              dateList.clear();
                              _selectDate = null;
                            }
                            break;
                          case SFCalendarStatus.range:
                            if (start != null && end != null) {
                              _selectRangeStart = start;
                              _selectRangeEnd = end;
                              month = start.month.toString().padLeft(2, '0');
                              day = start.day.toString().padLeft(2, '0');
                              var endMonth =
                                  end.month.toString().padLeft(2, '0');
                              var endDay = end.day.toString().padLeft(2, '0');
                              _selectDate =
                                  '${start.year}.$month.$day ~ ${end.year}.$endMonth.$endDay';
                            } else {
                              _selectRangeStart = null;
                              _selectRangeEnd = null;
                              _selectDate = null;
                            }
                            break;
                          case SFCalendarStatus.one:
                            if (selectedOne != null) {
                              _selectOne = selectedOne;
                              month =
                                  selectedOne.month.toString().padLeft(2, '0');
                              day = selectedOne.day.toString().padLeft(2, '0');
                              _selectDate = '${selectedOne.year}.$month.$day';
                            } else {
                              _selectOne = null;
                              _selectDate = null;
                            }
                            break;
                        }
                        setState(() {});
                      },
                    )),
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
    switch (widget.status) {
      case SFCalendarStatus.list:
        _selectedDateList.addAll(widget.initialDateList ?? []);
        break;
      case SFCalendarStatus.range:
        _selectRangeStart = widget.initialDateRange?.start;
        _selectRangeEnd = widget.initialDateRange?.end;

        break;
      case SFCalendarStatus.one:
        _selectOne = widget.initialDateOne;
        break;
    }
  }

  void popOverlay() {
    if (_overlayEntry != null) {
      hideDropdown();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        popOverlay();
        return true;
      },
      child: CompositedTransformTarget(
        link: _layerLink,
        child: GestureDetector(
          key: _buttonKey,
          onTap: toggleDropdown,
          child: Container(
            width: widget.width,
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: widget.borderRadius,
              border: Border.all(
                color: widget.outlineColor ?? SFColor.grayScale20,
                width: widget.outlineWidth,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    _selectDate ?? widget.text ?? 'Pick a date',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: widget.textStyle ??
                        SFTextStyle.b4B14(
                            color: _selectDate != null
                                ? SFColor.grayScale80
                                : SFColor.grayScale30),
                  ),
                ),
                widget.suffixIcon ??
                    Transform.rotate(
                        angle: 90 * 3.1415926535 / 180,
                        child: widget.suffixIcon ??
                            const Icon(
                              Icons.play_arrow,
                              color: SFColor.grayScale40,
                            ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
