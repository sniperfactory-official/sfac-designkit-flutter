import 'package:flutter/material.dart';

class SFRadioButton<T> extends StatefulWidget {
  SFRadioButton({
    Key? key,
    required this.groupValue,
    required this.onChanged,
    required this.value,
  }) : super(key: key);

  final T groupValue;
  final ValueChanged onChanged;
  final T value;
  @override
  _SFRadioButtonState createState() => _SFRadioButtonState();
}

class _SFRadioButtonState<T> extends State<SFRadioButton<T>> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onChanged(widget.value),
      child: Container(
        width: 20,
        height: 20,
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.black87),
        ),
        child: Container(
          margin: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color:
                widget.groupValue == widget.value ? Colors.blue : Colors.white,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
