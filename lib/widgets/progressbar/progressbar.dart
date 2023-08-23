import 'package:flutter/material.dart';
import 'package:sfac_design_flutter/sfac_design_flutter.dart';

// value 값이 null 아니면 duration은 null이어야 한다
// value 값과 duration 값이 둘 다 null 이면 LinearProgressIndicator
class SFProgressBar extends StatefulWidget {
  const SFProgressBar({
    Key? key,
    this.height = 30,
    this.value,
    this.duration,
    this.valueTextStyle,
    this.backgroundColor,
    this.valueBackgroundColor,
    this.animation = true,
    this.animationDuration,
    this.borderRadius = 16,
    this.textPadding = 16,
  })  : assert(value == null ? true : duration == null),
        assert(value != null ? (value >= 0.0 && value <= 100) : true),
        super(key: key);

  // ProgressBar 높이
  final double? height;

  // ProgressBar 값
  final double? value;

  // ProgressBar duration 시간에 따른 값 증가
  final Duration? duration;

  // ProgressBar value 텍스트 스타일
  final TextStyle? valueTextStyle;

  // ProgressBar 배경색
  final Color? backgroundColor;

  // ProgressBar value 배경색
  final Color? valueBackgroundColor;

  // value일 때 애니메이션 여부
  final bool animation;

  // value일 때 애니메이션 duraition
  final Duration? animationDuration;

  // ProgressBar 테두리 곡선
  final double borderRadius;

  // ProgressBar 텍스트 패딩
  final double textPadding;

  @override
  State<SFProgressBar> createState() => _SFProgressBarState();
}

class _SFProgressBarState extends State<SFProgressBar>
    with TickerProviderStateMixin {
  late TextPainter textPainter;
  late AnimationController _animationController;
  late Animation _animation;
  late double _progressPercent;

  @override
  void initState() {
    super.initState();
    _progressPercent = widget.value ?? 0;
    _animationController = AnimationController(
      vsync: this,
      duration: widget.duration ?? const Duration(seconds: 3),
    );
    _animationController.addListener(() {
      setState(() {});
    });
    if (widget.value != null && widget.animation) {
      _animation = Tween(begin: _progressPercent, end: widget.value)
          .animate(_animationController)
        ..addListener(() {
          setState(() {
            _progressPercent = _animation.value;
          });
        });
    }
    if (widget.duration != null) {
      _animationController.forward();
    }
  }

  @override
  void didUpdateWidget(SFProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != null &&
        oldWidget.value != widget.value &&
        widget.animation) {
      _animationController.duration =
          widget.animationDuration ?? const Duration(milliseconds: 300);
      _animation = Tween(begin: oldWidget.value, end: widget.value)
          .animate(_animationController);
      _animationController.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextSpan textSpan = TextSpan(
      text: widget.value != null
          ? '${(widget.animation ? _progressPercent : widget.value!).round()}%'
          : '${(_animationController.value * 100).toStringAsFixed(0)}%',
      style: widget.valueTextStyle ?? SFTextStyle.b3M16(color: Colors.white),
    );

    TextPainter textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();

    return widget.value != null || widget.duration != null
        ? LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              double width = constraints.maxWidth;
              double valueWidth = widget.value != null
                  ? width *
                      (widget.animation ? _progressPercent : widget.value!) /
                      100
                  : _animationController.value * width;
              return Container(
                width: width,
                height: widget.height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  color: widget.backgroundColor ?? SFColor.grayScale5,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width:
                          valueWidth < (textPainter.width + widget.textPadding)
                              ? (textPainter.width + widget.textPadding)
                              : valueWidth,
                      height: widget.height,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(widget.borderRadius),
                        color: widget.valueBackgroundColor ?? SFColor.primary50,
                      ),
                      child: Center(
                        child: Text(
                          textPainter.plainText,
                          style: widget.valueTextStyle ??
                              SFTextStyle.b3M16(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          )
        : ClipRRect(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            child: LinearProgressIndicator(
              minHeight: widget.height,
              color: widget.valueBackgroundColor ?? SFColor.primary50,
              backgroundColor: widget.backgroundColor ?? SFColor.grayScale5,
            ),
          );
  }
}
