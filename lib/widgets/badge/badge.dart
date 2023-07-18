import 'package:flutter/material.dart';
import 'package:sfac_design_flutter/sfac_design_flutter.dart';

enum SFBadgeStatus{
primary,
secondary,
outline,
destructive
}

class SFBadge extends StatefulWidget {
  const SFBadge({
    super.key,
    this.child,
    this.borderRadius = 4,
    this.padding,
    required this.type
  });

  //Badge안에 위젯
  final Widget? child;

  //Badge모서리 곡선
  final double borderRadius;

  //Badge안에 위젯 padding
  final EdgeInsetsGeometry? padding;

  //Badge 타입
  final SFBadgeStatus type;

  @override
  State<SFBadge> createState() => _SFBadgeState();
}

class _SFBadgeState extends State<SFBadge> {
  //Badge 테두리
  Border? border;
  //Text위젯의 textStyle
  TextStyle? textStyle;
  //Badge 배경색
  Color? backgroundColor;

  initAttributes() {
    switch (widget.type){
      case SFBadgeStatus.primary:
      border = Border.all(color: Colors.transparent);
      backgroundColor = SFColor.primary80;
      textStyle = SFTextStyle.b5R12(color: Colors.white);
      break;
      case SFBadgeStatus.secondary:
      border = Border.all(color: Colors.transparent);
      backgroundColor = SFColor.grayScale5;
      textStyle = SFTextStyle.b5R12(color: SFColor.grayScale60);
      break;
      case SFBadgeStatus.outline:
      border = Border.all(color: SFColor.primary40);
      backgroundColor = SFColor.primary5;
      textStyle = SFTextStyle.b5R12(color: SFColor.primary60);
      break;
      case SFBadgeStatus.destructive:
      border = Border.all(color: Colors.transparent);
      backgroundColor = SFColor.red;
      textStyle = SFTextStyle.b5R12(color: Colors.white);
      break;
      default:
      border = Border.all(color: Colors.transparent);
      backgroundColor = SFColor.primary80;
      textStyle = SFTextStyle.b5R12(color: Colors.white);
      break;
    }
  }

  @override
  void initState() {
    super.initState();
    initAttributes();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: backgroundColor,
          border: border,
          borderRadius: BorderRadius.circular(widget.borderRadius)
          ),
      child: Padding(
          padding:
              widget.padding ?? const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
          child: AnimatedDefaultTextStyle(
            style: textStyle!,
            duration: kThemeChangeDuration,
            child: widget.child ?? const Text(''),
          )
      ),
    );
  }
}