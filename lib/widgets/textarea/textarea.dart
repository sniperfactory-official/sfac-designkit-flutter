import 'package:flutter/material.dart';
import 'package:sfac_design_flutter/sfac_design_flutter.dart';

class SFTextArea extends StatelessWidget {
  const SFTextArea({
    super.key,
    this.controller,
    this.writer,
    this.hintText,
    this.hintStyle,
    this.textStyle,
    this.minLines = 11,
    this.maxLines = 11,
    this.width,
    this.readOnly = false,
    this.radius = 10,
    this.borderColor,
    this.onChanged,
    this.onSaved,
  });

  //텍스트 필드 컨트롤러
  final TextEditingController? controller;

  //작성자 이름
  final String? writer;

  //힌트 텍스트
  final String? hintText;

  //힌트 텍스트 스타일
  final TextStyle? hintStyle;

  //입력텍스트 스타일
  final TextStyle? textStyle;

  //텍스트필드에 표시될 최소 행 수
  final int? minLines;

  //텍스트필드에 허용되는 최대 행 수
  final int? maxLines;

  //가로 너비
  final double? width;

  //읽기전용 텍스트필드
  final bool readOnly;

  //radius
  final double radius;

  //테두리 색
  final Color? borderColor;

  //onChanged: TextArea 칸의 내용이 바로바로 바뀔 때 호출
  final Function(String)? onChanged;

  //onSaved: 입력된 텍스트를 저장할 때 호출
  final Function(String?)? onSaved;

  @override
  Widget build(BuildContext context) {
    final Color hintColor = readOnly ? SFColor.grayScale10 : SFColor.grayScale30;

    return Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: borderColor ?? SFColor.grayScale20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: controller,
              minLines: minLines,
              maxLines: maxLines,
              readOnly: readOnly,
              onChanged: onChanged,
              onSaved: onSaved,
              style: textStyle ??
                  const TextStyle(fontSize: 15, color: Colors.black),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle:
                    hintStyle ?? SFTextStyle.b3R16(color: hintColor),
                border: InputBorder.none,
              ),
            ),
            if (writer != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: Row(
                  children: [
                    Text('작성자',
                        style: SFTextStyle.b5B12(color: SFColor.grayScale40)),
                    const SizedBox(width: 6),
                    Text(writer!,
                        style: SFTextStyle.b5B12(color: SFColor.grayScale60)),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
