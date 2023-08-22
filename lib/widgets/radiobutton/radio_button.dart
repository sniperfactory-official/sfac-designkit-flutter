import 'package:flutter/material.dart';
import 'package:sfac_design_flutter/util/sfac_color.dart';

enum SFRadioButtonType {
  primary,
}

class SFRadioButton<T> extends StatefulWidget {
  const SFRadioButton({
    Key? key,
    required this.groupValue,
    required this.onChanged,
    required this.value,
    this.type,
    this.width = 16,
    this.height = 16,
    this.valueVisible = true,
    this.valueSpacing = 8,
    this.valueTextStyle = const TextStyle(
      color: SFColor.grayScale80,
    ),
  }) : super(key: key);

  final T groupValue;
  final ValueChanged onChanged;
  final T value;
  final SFRadioButtonType? type;
  final double? width;
  final double? height;
  final bool valueVisible;
  final double valueSpacing;
  final TextStyle? valueTextStyle;
  @override
  _SFRadioButtonState createState() => _SFRadioButtonState();
}

class _SFRadioButtonState<T> extends State<SFRadioButton<T>> {
  Color _outlineColor = SFColor.grayScale100;
  @override
  Widget build(BuildContext context) {
    switch (widget.type) {
      case SFRadioButtonType.primary:
        _outlineColor = SFColor.primary30;
        break;
      default:
    }

    return GestureDetector(
      onTap: () => widget.onChanged(widget.value),
      child: Row(
        children: [
          Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: _outlineColor),
            ),
            child: Container(
              margin: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: widget.groupValue == widget.value
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
