import 'package:flutter/material.dart';
import '../../util/sfac_color.dart';

enum SFCheckBoxType {
  basic,
  primary,
}

class SFCheckBox<T> extends StatefulWidget {
  const SFCheckBox({
    Key? key,
    required this.onChanged,
    required this.value,
    this.label,
    this.type = SFCheckBoxType.basic,
    this.size = 16,
    this.margin = const EdgeInsets.all(8),
    this.radius = 4,
    this.labelSpcing = 8,
    this.labelStyle = const TextStyle(
      color: SFColor.grayScale80,
    ),
  }) : super(key: key);

  // CheckBox를 클릭했을 때 호출되는 이벤트 핸들러
  // value는 bool 타입을 가짐
  final ValueChanged<bool> onChanged;

  // CheckBox의 부가 설명을 위한 값
  final String? label;

  // CheckBox의 타입으로 basic, primary가 있음
  final SFCheckBoxType type;

  // CheckBox의 크기
  final double size;

  // CheckBox 바깥의 여백
  final EdgeInsets margin;

  // CheckBox와 label 사이의 여백
  final double labelSpcing;

  // CheckBox 우측 value 텍스트의 스타일
  final TextStyle? labelStyle;

  // CheckBox border
  final double radius;

  final bool value;

  @override
  State<SFCheckBox> createState() => _SFCheckBoxState();
}

class _SFCheckBoxState extends State<SFCheckBox> {
  Color _backgroundColor = Colors.transparent;
  Color _outlineColor = SFColor.grayScale100;
  Color _iconColor = SFColor.primary60;
  late bool _isChecked;

  @override
  void initState() {
    _isChecked = widget.value;
    super.initState();
  }

  void onSwitch() {
    setState(() {
      _isChecked = !_isChecked;
    });
    widget.onChanged(_isChecked);
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.type) {
      case SFCheckBoxType.basic:
        break;
      case SFCheckBoxType.primary:
        _backgroundColor = SFColor.primary60;
        _outlineColor = SFColor.primary60;
        _iconColor = Colors.white;
        break;
    }
    return Container(
      margin: widget.margin,
      child: GestureDetector(
        onTap: onSwitch,
        child: Row(
          children: [
            Container(
              width: widget.size,
              height: widget.size,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border.all(
                    color: _outlineColor,
                    strokeAlign: BorderSide.strokeAlignOutside),
                borderRadius: BorderRadius.circular(widget.radius),
              ),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: widget.value == true
                      ? _backgroundColor
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(widget.radius),
                ),
                child: Container(
                  alignment: Alignment.center,
                  child: Icon(
                    widget.value ? Icons.check_rounded : null,
                    size: widget.size - 2,
                    color: _iconColor,
                  ),
                ),
              ),
            ),
            widget.label != null
                ? Row(
                    children: [
                      SizedBox(
                        width: widget.labelSpcing,
                      ),
                      Text(
                        widget.label!,
                        style: widget.labelStyle,
                      ),
                    ],
                  )
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
