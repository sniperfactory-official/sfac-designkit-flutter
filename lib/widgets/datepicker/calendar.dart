import 'package:flutter/material.dart';
import 'package:sfac_design_flutter/sfac_design_flutter.dart';

typedef GetSelectedDate = void Function(DateTime? start, DateTime? end,
    List<DateTime>? selectedDateList, DateTime? selectedOne);

enum SFCalendarStatus { list, range, one }

enum SFCalendarTheme { light, dark }

class SFCalendar extends StatefulWidget {
  const SFCalendar({
    Key? key,
    this.type = SFCalendarStatus.one,
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
    this.width,
    this.padding,
    this.getSelectedDate,
    this.todayMark = true,
  })  : assert(
            verticalSpacing >= 0 && horizontalSpacing >= 0 && contentSize > 0),
        super(key: key);
  // 캘린터 status
  // list 선택한 날짜 리스트
  // range 선택한 기간
  // one 선택한 날짜 하나
  final SFCalendarStatus type;

  // 캘린터 테마 dart, light
  final SFCalendarTheme theme;

  // 초기 선택한 날짜 리스트
  final List<DateTime>? initialDateList;

  // 초기 선택한 기간
  final DateTimeRange? initialDateRange;

  // 초기 선택한 날짜
  final DateTime? initialDateOne;

  // 캘린더 배경색
  final Color? backgroundColor;

  // 캘린터 텍스트 컬러
  final Color? textColor;

  // 선택한 날짜 배경색
  final Color selectedColor;

  // 선택한 기간 배경색
  final Color rangeColor;

  // 선택한 날짜 텍스트 색
  final Color? selectedTextColor;

  // 캘린터 테두리 곡선
  final BorderRadius borderRadius;

  // 캘린더 내용 사이즈 날짜, 요일, 년도, 아이콘 크기 등 비율은 고정되어있다
  final double contentSize;

  // vertical 간격
  final double verticalSpacing;

  // horizontal 간격
  final double horizontalSpacing;

  // 가로 너비
  final double? width;

  // 캘린더 padding
  final EdgeInsetsGeometry? padding;

  // 선택한 list, range(start, end), one 를 받을 수 있다.
  final GetSelectedDate? getSelectedDate;

  // 초기 오늘 날짜 마크를 할 것인지
  final bool todayMark;

  @override
  State<SFCalendar> createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<SFCalendar> {
  final List<DateTime> _calender = [];

  final List<DateTime> _selectedDateList = [];

  DateTime? _selectRangeStart;
  DateTime? _selectRangeEnd;
  DateTime? _selectOne;

  late Color _selectedTextColor;

  late DateTime _viewMonth;

  bool _isSelected = false;

  @override
  void initState() {
    super.initState();
    switch (widget.type) {
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
    _viewMonth = DateTime.now();
    _selectedTextColor = widget.selectedTextColor ?? Colors.white;
    if (_selectedDateList.isEmpty &&
        _selectRangeStart == null &&
        _selectRangeEnd == null &&
        _selectOne == null) {
      _isSelected = !widget.todayMark;
    } else {
      _isSelected = true;
    }
    viewCalender();
    setState(() {});
  }

  List<String> weekNames = ['일', '월', '화', '수', '목', '금', '토'];

  void viewCalender() {
    _calender.clear();

    int startWeekDay =
        DateTime(_viewMonth.year, _viewMonth.month, 1).weekday == 7
            ? 0
            : DateTime(_viewMonth.year, _viewMonth.month, 1).weekday;

    for (int i = 1; i <= 42; i++) {
      _calender
          .add(DateTime(_viewMonth.year, _viewMonth.month, i - startWeekDay));
    }
  }

  void goBackMonth() {
    _viewMonth = DateTime(_viewMonth.year, _viewMonth.month - 1, 1);
    viewCalender();
  }

  void goFrontMonth() {
    _viewMonth = DateTime(_viewMonth.year, _viewMonth.month + 1, 1);
    viewCalender();
  }

  void selectedOne(DateTime date) {
    _selectOne != date ? _selectOne = date : _selectOne = null;
  }

  void selectDate(DateTime date) {
    if (!_selectedDateList.contains(date)) {
      _selectedDateList.add(date);
    } else {
      _selectedDateList.removeWhere((e) =>
          e.year == date.year && e.month == date.month && e.day == date.day);
    }
  }

  void selectDateRange(DateTime date) {
    if (_selectRangeStart == null) {
      _selectRangeStart = date;
      return;
    } else if (_selectRangeEnd != null) {
      _selectRangeStart = date;
      _selectRangeEnd = null;
      return;
    } else if (_selectRangeStart == date) {
      _selectRangeStart = null;
      return;
    } else if (date.isBefore(_selectRangeStart!)) {
      _selectRangeStart = date;
      return;
    } else if (date.isAfter(_selectRangeStart!)) {
      _selectRangeEnd = date;
    }
  }

  bool isRange(int index1, int index2) {
    return widget.type == SFCalendarStatus.range &&
        _selectRangeStart != null &&
        _selectRangeEnd != null &&
        (_selectRangeStart!.isBefore(_calender[index1 * 7 + index2]) &&
            _selectRangeEnd!.isAfter(
              _calender[index1 * 7 + index2]
                  .add(const Duration(hours: 23, minutes: 59, seconds: 59)),
            ));
  }

  selectedDate(int index1, int index2) {
    switch (widget.type) {
      case SFCalendarStatus.list:
        selectDate(_calender[index1 * 7 + index2]);
        if (widget.getSelectedDate != null) {
          widget.getSelectedDate!(null, null, _selectedDateList, null);
        }
        break;
      case SFCalendarStatus.range:
        selectDateRange(_calender[index1 * 7 + index2]);
        if (widget.getSelectedDate != null) {
          widget.getSelectedDate!(
              _selectRangeStart, _selectRangeEnd, null, null);
        }
        break;
      case SFCalendarStatus.one:
        selectedOne(_calender[index1 * 7 + index2]);
        if (widget.getSelectedDate != null) {
          widget.getSelectedDate!(null, null, null, _selectOne);
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      padding: widget.padding ??
          const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 30,
          ),
      decoration: BoxDecoration(
        borderRadius: widget.borderRadius,
        color: widget.backgroundColor ??
            (widget.theme == SFCalendarTheme.light
                ? Colors.white
                : Colors.black),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {
                  goBackMonth();
                  setState(() {});
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: widget.textColor ??
                        (widget.theme == SFCalendarTheme.light
                            ? SFColor.grayScale80
                            : Colors.white),
                    size: widget.contentSize + 2,
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    '${_viewMonth.year}년 ${_viewMonth.month}월',
                    style: TextStyle(
                      fontFamily: 'PretendardBold',
                      fontSize: widget.contentSize + 4,
                      color: widget.textColor ??
                          (widget.theme == SFCalendarTheme.light
                              ? SFColor.grayScale80
                              : Colors.white),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  goFrontMonth();
                  setState(() {});
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: widget.textColor ??
                        (widget.theme == SFCalendarTheme.light
                            ? SFColor.grayScale80
                            : Colors.white),
                    size: widget.contentSize + 2,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...List.generate(
                7,
                (index) => Expanded(
                  child: Text(
                    weekNames[index],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'PretendardMedium',
                      fontSize: widget.contentSize,
                      color: index == 0
                          ? Colors.red
                          : index == 6
                              ? SFColor.primary100
                              : widget.textColor ??
                                  (widget.theme == SFCalendarTheme.light
                                      ? SFColor.grayScale80
                                      : Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: widget.verticalSpacing),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ...List.generate(
                6,
                (index1) => Padding(
                  padding: EdgeInsets.only(bottom: widget.verticalSpacing),
                  child: Row(
                    children: [
                      ...List.generate(
                        7,
                        (index2) => Expanded(
                          child: GestureDetector(
                            onTap: _calender[index1 * 7 + index2].month !=
                                    _viewMonth.month
                                ? () {
                                    _viewMonth = DateTime(
                                        _calender[index1 * 7 + index2].year,
                                        _calender[index1 * 7 + index2].month);
                                    selectedDate(index1, index2);
                                    viewCalender();
                                    _isSelected = true;
                                    setState(() {});
                                  }
                                : () {
                                    _isSelected = true;
                                    selectedDate(index1, index2);
                                    setState(() {});
                                  },
                            child: Container(
                              decoration: BoxDecoration(
                                color: isRange(index1, index2)
                                    ? widget.rangeColor
                                    : null,
                                gradient: _rangeGradient(
                                    _calender[index1 * 7 + index2]),
                              ),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: widget.horizontalSpacing / 2,
                                  vertical: widget.verticalSpacing / 2,
                                ),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _dayBoxColor(
                                      _calender[index1 * 7 + index2]),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: Text(
                                    _calender[index1 * 7 + index2]
                                        .day
                                        .toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'PretendardMedium',
                                      fontSize: widget.contentSize,
                                      color: dayTextColor(
                                        _calender[index1 * 7 + index2],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Color _dayBoxColor(DateTime date) {
    if (_isSelected) {
      switch (widget.type) {
        case SFCalendarStatus.list:
          return _selectedDateList.indexWhere((e) =>
                      e.year == date.year &&
                      e.month == date.month &&
                      e.day == date.day) !=
                  -1
              ? widget.selectedColor
              : Colors.transparent;
        case SFCalendarStatus.range:
          return ((_selectRangeStart?.year == date.year &&
                      _selectRangeStart?.month == date.month &&
                      _selectRangeStart?.day == date.day) ||
                  (_selectRangeEnd?.year == date.year &&
                      _selectRangeEnd?.month == date.month &&
                      _selectRangeEnd?.day == date.day))
              ? widget.selectedColor
              : Colors.transparent;
        case SFCalendarStatus.one:
          return (_selectOne != null &&
                  _selectOne!.year == date.year &&
                  _selectOne!.month == date.month &&
                  _selectOne!.day == date.day)
              ? widget.selectedColor
              : Colors.transparent;
      }
    } else {
      return (date.year == DateTime.now().year &&
              date.month == DateTime.now().month &&
              date.day == DateTime.now().day)
          ? widget.selectedColor
          : Colors.transparent;
    }
  }

  Color dayTextColor(DateTime date) {
    int overStart = 0;
    int underEnd = 0;
    if (widget.type == SFCalendarStatus.range &&
        _selectRangeStart != null &&
        _selectRangeStart != null) {
      overStart = _selectRangeStart?.compareTo(date) ?? 0;
      underEnd = _selectRangeEnd?.compareTo(date) ?? 0;
    }
    if (_isSelected) {
      switch (widget.type) {
        case SFCalendarStatus.list:
          return _selectedDateList.indexWhere((e) =>
                      e.year == date.year &&
                      e.month == date.month &&
                      e.day == date.day) !=
                  -1
              ? _selectedTextColor
              : date.month != _viewMonth.month
                  ? SFColor.grayScale30
                  : date.weekday == 6
                      ? SFColor.primary100
                      : date.weekday == 7
                          ? SFColor.red
                          : widget.textColor ??
                              (widget.theme == SFCalendarTheme.light
                                  ? SFColor.grayScale80
                                  : Colors.white);
        case SFCalendarStatus.range:
          return ((_selectRangeStart?.year == date.year &&
                      _selectRangeStart?.month == date.month &&
                      _selectRangeStart?.day == date.day) ||
                  (_selectRangeEnd?.year == date.year &&
                      _selectRangeEnd?.month == date.month &&
                      _selectRangeEnd?.day == date.day) ||
                  (overStart < 0 && underEnd > 0))
              ? _selectedTextColor
              : date.month != _viewMonth.month
                  ? SFColor.grayScale30
                  : date.weekday == 6
                      ? SFColor.primary100
                      : date.weekday == 7
                          ? SFColor.red
                          : widget.textColor ??
                              (widget.theme == SFCalendarTheme.light
                                  ? SFColor.grayScale80
                                  : Colors.white);
        case SFCalendarStatus.one:
          return (_selectOne != null &&
                  _selectOne!.year == date.year &&
                  _selectOne!.month == date.month &&
                  _selectOne!.day == date.day)
              ? _selectedTextColor
              : date.month != _viewMonth.month
                  ? SFColor.grayScale30
                  : date.weekday == 6
                      ? SFColor.primary100
                      : date.weekday == 7
                          ? SFColor.red
                          : widget.textColor ??
                              (widget.theme == SFCalendarTheme.light
                                  ? SFColor.grayScale80
                                  : Colors.white);
      }
    } else {
      return (date.year == DateTime.now().year &&
              date.month == DateTime.now().month &&
              date.day == DateTime.now().day)
          ? _selectedTextColor
          : date.month != _viewMonth.month
              ? SFColor.grayScale30
              : date.weekday == 6
                  ? SFColor.primary100
                  : date.weekday == 7
                      ? SFColor.red
                      : widget.textColor ??
                          (widget.theme == SFCalendarTheme.light
                              ? SFColor.grayScale80
                              : Colors.white);
    }
  }

  LinearGradient? _rangeGradient(DateTime date) {
    if (_selectRangeStart != null && _selectRangeEnd != null) {
      if (_selectRangeStart?.year == date.year &&
          _selectRangeStart?.month == date.month &&
          _selectRangeStart?.day == date.day) {
        return LinearGradient(
          tileMode: TileMode.clamp,
          colors: [
            Colors.transparent,
            widget.rangeColor,
          ],
          stops: const [.4, .5],
        );
      } else if (_selectRangeEnd?.year == date.year &&
          _selectRangeEnd?.month == date.month &&
          _selectRangeEnd?.day == date.day) {
        return LinearGradient(
          tileMode: TileMode.clamp,
          colors: [
            widget.rangeColor,
            Colors.transparent,
          ],
          stops: const [.4, .5],
        );
      }
    } else {
      return null;
    }
    return null;
  }
}
