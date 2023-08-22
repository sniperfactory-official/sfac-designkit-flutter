import 'package:flutter/material.dart';
import 'package:sfac_design_flutter/util/sfac_color.dart';

enum SFRadioButtonType {
  basic,
  primary,
}

class SFRadioButton<T> extends StatefulWidget {
  const SFRadioButton({
    Key? key,
    required this.group,
    required this.onChanged,
    required this.value,
    this.type = SFRadioButtonType.basic,
    this.size = 16,
    this.circleSpacing = 2,
    this.valueVisible = true,
    this.valueSpacing = 8,
    this.valueTextStyle = const TextStyle(
      color: SFColor.grayScale80,
    ),
  }) : super(key: key);

  // Radio Button을 그룹화 시킬 값
  final T group;

  // Radio Button이 선택되었을 때 호출되는 이벤트 핸들러입니다.
  // value는 Radio Button의 실제 값이며, 선택된 버튼의 value가 이 파라미터로 전달됨
  final ValueChanged onChanged;

  // Radio Button의 값
  final T value;

  // Radio Button의 타입으로 basic, primary가 있으며 현재 테두리 색의 변화만 있음
  final SFRadioButtonType type;

  // Radio Button의 크기
  final double size;

  // Radio Button 선택 시 테두리와 선택 표시 사이의 여백 크기
  final double circleSpacing;

  // Radio Button 우측에 value가 보이게 할 것인지의 여부
  final bool valueVisible;

  // Radio Button과 value 사이의 여백
  final double valueSpacing;

  // Radio Button 우측 value 텍스트의 스타일
  final TextStyle? valueTextStyle;

  @override
  SFRadioButtonState createState() => SFRadioButtonState();
}

class SFRadioButtonState<T> extends State<SFRadioButton<T>> {
  Color _outlineColor = SFColor.grayScale100;
  @override
  Widget build(BuildContext context) {
    switch (widget.type) {
      case SFRadioButtonType.basic:
        break;
      case SFRadioButtonType.primary:
        _outlineColor = SFColor.primary30;
        break;
    }

    return GestureDetector(
      onTap: () => widget.onChanged(widget.value),
      child: Row(
        children: [
          Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: _outlineColor),
            ),
            child: Container(
              margin: EdgeInsets.all(
                widget.circleSpacing,
              ),
              decoration: BoxDecoration(
                color: widget.group == widget.value
                    ? SFColor.primary60
                    : Colors.transparent,
                shape: BoxShape.circle,
              ),
            ),
          ),
          widget.valueVisible
              ? Row(
                  children: [
                    SizedBox(
                      width: widget.valueSpacing,
                    ),
                    Text(
                      widget.value.toString(),
                      style: widget.valueTextStyle,
                    ),
                  ],
                )
              : const SizedBox.shrink()
        ],
      ),
    );
  }
}
