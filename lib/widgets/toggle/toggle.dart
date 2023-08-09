import 'package:flutter/material.dart';
import 'package:sfac_design_flutter/sfac_design_flutter.dart';

class SFToggle extends StatefulWidget {
  const SFToggle({
    super.key,
    this.size = 50,
    this.initialValue  = false,
    this.disabledBackgroundColor,
    this.enabledBackgroundColor,
    this.disabledTrackColor,
    this.enabledTrackColor,
    required this.onChanged,
  });

  //Toggle size
  final double size;

  //스위치 상태value
  final bool initialValue ;

  //비활성화 배경색
  final Color? disabledBackgroundColor;

  //활성화 배경색
  final Color? enabledBackgroundColor;

  //비활성화 동그라미색
  final Color? disabledTrackColor;

  //활성화 동그라미색
  final Color? enabledTrackColor;

  //onChanged 이벤트
  final ValueChanged<bool?> onChanged;

  @override
  State<SFToggle> createState() => _SFToggleState();
}

class _SFToggleState extends State<SFToggle> {
  late bool isSwitch;
  @override
  void initState() {
    isSwitch = widget.initialValue ;
    super.initState();
  }

  void onSwitch() {
    setState(() {
      isSwitch = !isSwitch;
    });
    widget.onChanged(isSwitch);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSwitch,
      child: Container(
        width: widget.size,
        height: widget.size * 0.5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9999),
          color: isSwitch ? 
          widget.enabledBackgroundColor ?? SFColor.primary10
          : widget.disabledBackgroundColor ?? SFColor.grayScale10,
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              top: 0,
              bottom: 0,
              duration: const Duration(milliseconds: 200),
              curve: Curves.ease,
              left: isSwitch ? widget.size * 0.5 : widget.size * 0.1,
              child: Container(
                width: widget.size * 0.4,
                height: widget.size * 0.4,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSwitch ?
                  widget.enabledTrackColor ?? SFColor.primary80 
                  : widget.disabledTrackColor ?? SFColor.grayScale30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
