import 'package:flutter/material.dart';
import 'package:sfac_design_flutter/sfac_design_flutter.dart';

class SFTable extends StatefulWidget {
  const SFTable(
      {super.key,
      required this.headers,
      required this.data,
      this.ellipsis =false,
      this.textStyle = const TextStyle(),
      this.headersTextColor = SFColor.grayScale40,
      this.firstColumnTextColor = SFColor.grayScale80,
      this.otherDataTextColor = SFColor.grayScale60,
      this.dividerThickness,
      this.dividerColor = SFColor.grayScale20,
      this.padding,
      this.width,
      this.tablePadding,
      this.tableMargin
      });

  //열 (첫 행에 들어가는 데이터 리스트 각 열의 이름)
  final List<String> headers;

  //행 (각 행의 셀들에 들어갈 데이터 리스트)
  final List<List<dynamic>> data;

  //TextOverflow시 생략여부
  final bool ellipsis;

  //Table안에 TextStyle
  final TextStyle textStyle;

  //headers TextColor
  final Color headersTextColor;

  //첫 번째 열 TextColor
  final Color firstColumnTextColor;

  //나머지 데이터 TextColor
  final Color otherDataTextColor;

  //구분선 굵기
  final double? dividerThickness;

  //구분선 Color
  final Color dividerColor;

  //Table Text Padding
  final EdgeInsetsGeometry? padding;

  //Table 너비
  final double? width;

  //Table padding
  final EdgeInsetsGeometry? tablePadding;

  //Table margin
  final EdgeInsetsGeometry? tableMargin;

  @override
  SFTableState createState() => SFTableState();
}

class SFTableState extends State<SFTable> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      padding: widget.tablePadding,
      margin: widget.tableMargin,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: widget.dividerThickness ?? 1.0,
                    color: widget.dividerColor,
                  ),
                ),
              ),
              child: Row(
                children: widget.headers.asMap().entries.map((entry) {
                  int index = entry.key;
                  String column = entry.value;

                  return Expanded(
                    child: Container(
                      padding: widget.padding ??
                          const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 12),
                      child: Text(
                        column,
                        overflow: widget.ellipsis ? TextOverflow.ellipsis : null,
                        textAlign: index == widget.headers.length - 1
                            ? TextAlign.right
                            : null,
                        style: widget.textStyle.copyWith(
                          color: widget.headersTextColor,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            ...widget.data.map((row) => Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: widget.dividerThickness ?? 1.0,
                        color: widget.dividerColor,
                      ),
                    ),
                  ),
                  child: Row(
                    children: row.asMap().entries.map((entry) {
                      int index = entry.key;
                      dynamic value = entry.value;
                      Color textColor;
                      if (index == 0) {
                        textColor = widget.firstColumnTextColor;
                      } else {
                        textColor = widget.otherDataTextColor;
                      }

                      return Expanded(
                        child: Container(
                          padding: widget.padding ??
                              const EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 12),
                          child: Text(
                            value.toString(),
                            overflow: widget.ellipsis ? TextOverflow.ellipsis : null,
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
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
