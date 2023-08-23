import 'package:flutter/material.dart';
import 'package:sfac_design_flutter/sfac_design_flutter.dart';

class SFTable extends StatefulWidget {
  const SFTable({
    super.key,
    required this.columns,
    required this.data,
    this.textStyle = const TextStyle(),
    this.columnsTextColor = SFColor.grayScale40,
    this.firstDataTextColor = SFColor.grayScale80,
    this.otherDataTextColor = SFColor.grayScale60,
    this.dividerThickness,
    this.dividerColor = SFColor.grayScale20,
    this.padding,
  });

  //열 (첫 행에 들어가는 데이터 리스트 각 열의 이름)
  final List<String> columns;

  //행 (각 행의 셀들에 들어갈 데이터 리스트)
  final List<List<dynamic>> data;

  //Table안에 TextStyle
  final TextStyle textStyle;

  //columns TextColor
  final Color columnsTextColor;

  //첫 번째 데이터 TextColor
  final Color firstDataTextColor;

  //나머지 데이터 TextColor
  final Color otherDataTextColor;

  //구분선 굵기
  final double? dividerThickness;

  //구분선 Color
  final Color dividerColor;

  //Table Text Padding
  final EdgeInsetsGeometry? padding;



  @override
  SFTableState createState() => SFTableState();
}

class SFTableState extends State<SFTable> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: widget.columns.asMap().entries.map((entry) {
              int index = entry.key;
              String column = entry.value;

              return Expanded(
                child: Container(
                  padding: widget.padding ??
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: widget.dividerThickness ?? 1.0,
                        color: widget.dividerColor,
                      ),
                    ),
                  ),
                  child: Text(
                    column,
                    textAlign: index == widget.columns.length - 1
                    //마지막 Amount부분 구분선 오른쪽 끝 위치
                        ? TextAlign.right
                        : null,
                        //원본 객체를 변경하지 않고 특정 값만 바꾼 새로운 객체를 반환하기 위함copywith
                    style: widget.textStyle.copyWith(
                      color: widget.columnsTextColor,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          //각 행에 대한 Row위젯을 만듦
          ...widget.data.map((row) => Row(
            //인덱스와 값을 포함하는 항목생성
                children: row.asMap().entries.map((entry) {
                  int index = entry.key;
                  dynamic value = entry.value;
                  Color textColor;
                  //첫번째 데이터
                  if (index == 0) {
                    textColor = widget.firstDataTextColor;
                  } else {
                    textColor = widget.otherDataTextColor;
                  }

                  return Expanded(
                    child: Container(
                      padding: widget.padding ??
                          const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 12),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: widget.dividerThickness ?? 1.0,
                            color: widget.dividerColor,
                          ),
                        ),
                      ),
                      child: Text(
                        value.toString(),
                        textAlign: index == row.asMap().entries.length - 1
                            ? TextAlign.right
                            : null,
                        style: widget.textStyle.copyWith(
                          color: textColor,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              )),
        ],
      ),
    );
  }
}