import 'package:flutter/material.dart';
import 'package:sfac_design_flutter/sfac_design_flutter.dart';

enum SFAlertStatus { primary, outlineWithIcon, outline }

class SFAlert extends StatefulWidget {
  const SFAlert({
    super.key,
    this.top,
    this.left,
    this.right,
    this.height,
    this.heightSpacing,
    required this.status,
    required this.title,
    this.titleLeading,
    this.closeWidget,
    this.titleTextStyle,
    required this.content,
    this.padding,
    this.contentTextStyle,
    this.backgroundColor,
    this.borderColor,
    required this.onTap,
    this.borderRadius,
  });

  // alert의 세로 축 위치를 지정, 0.0 부터 1.0까지 사용가능
  final double? top;

  // alert의 왼쪽, 오른쪽 여백 값
  final double? left;
  final double? right;

  // alert의 높이
  final double? height;

  // title과 content의 사이 간격
  final double? heightSpacing;

  // Alert의 status primary, outlineWithIcon, outline
  final SFAlertStatus status;

  // alert의 title, laeding과 trailing 사이에서 최대너비를 가진다
  final String title;

  // title의 laeding 위젯 위젯이 있을 시 title과 6의 간격이 있다
  final Widget? titleLeading;

  // title의 close 위젯
  final Widget? closeWidget;

  // title의 TextStyle
  final TextStyle? titleTextStyle;

  // alert의 content
  final String content;

  // alert의 padding
  final EdgeInsets? padding;

  // content의 TextStyle
  final TextStyle? contentTextStyle;

  // alert의 backgroundColor
  final Color? backgroundColor;

  // alert의 테두리색
  final Color? borderColor;

  // alert의 테두리 곡선
  final BorderRadius? borderRadius;

  // closeWidget의 onTap alert이 remove 된다
  final VoidCallback onTap;

  @override
  State<SFAlert> createState() => _SFAlertState();
}

class _SFAlertState extends State<SFAlert> with SingleTickerProviderStateMixin {
  Widget? _titleLeading;

  @override
  Widget build(BuildContext context) {
    switch (widget.status) {
      case SFAlertStatus.primary:
        _titleLeading = const Icon(
          Icons.warning_amber_outlined,
          color: Colors.white,
          size: 16,
        );
        break;
      case SFAlertStatus.outlineWithIcon:
        _titleLeading = const Icon(
          Icons.warning_amber_outlined,
          color: Color(0xFFFF4D4D),
          size: 16,
        );
        break;
      case SFAlertStatus.outline:
        break;
    }

    return Positioned(
      top: widget.top != null
          ? MediaQuery.of(context).size.height * widget.top!
          : MediaQuery.of(context).size.height * 0.1,
      left: widget.left ?? 16,
      right: widget.right ?? 16,
      child: Material(
        color: Colors.transparent,
        child: Container(
          height: widget.height,
          padding: widget.padding ??
              const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                offset: Offset(3, 3),
                color: Color.fromRGBO(206, 206, 206, 0.47),
                blurRadius: 9,
              )
            ],
            color: widget.backgroundColor ??
                (widget.status == SFAlertStatus.primary
                    ? const Color(0xFFFF4D4D)
                    : const Color(0xFFFFEBEB)),
            borderRadius: widget.borderRadius ?? BorderRadius.circular(10.0),
            border: Border.all(
              color: widget.borderColor ??
                  (widget.status == SFAlertStatus.primary
                      ? Colors.transparent
                      : const Color(0xFFFF4D4D)),
            ),
          ),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    widget.titleLeading ?? _titleLeading ?? const SizedBox(),
                    SizedBox(width: _titleLeading != null ? 6 : 0),
                    Expanded(
                      child: Text(
                        widget.title,
                        style: widget.titleTextStyle ??
                            SFTextStyle.b4B14(
                              color: widget.status == SFAlertStatus.primary
                                  ? Colors.white
                                  : SFColor.grayScale80,
                            ),
                      ),
                    ),
                    widget.closeWidget ??
                        GestureDetector(
                          onTap: widget.onTap,
                          child: Icon(
                            Icons.close,
                            color: widget.status == SFAlertStatus.primary
                                ? Colors.white
                                : const Color(0xFFFF4D4D),
                          ),
                        ),
                  ],
                ),
                SizedBox(height: widget.heightSpacing),
                Text(
                  widget.content,
                  style: widget.contentTextStyle ??
                      SFTextStyle.b5R12(
                        color: widget.status == SFAlertStatus.primary
                            ? Colors.white
                            : SFColor.grayScale60,
                      ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void alert(
  BuildContext context, {
  double? top,
  double? left,
  double? right,
  double? height,
  double? heightSpacing = 4,
  SFAlertStatus status = SFAlertStatus.primary,
  required String title,
  Widget? titleLeading,
  Widget? closeWidget,
  TextStyle? titleTextStyle,
  required String content,
  EdgeInsets? padding,
  TextStyle? contentTextStyle,
  Color? backgroundColor,
  Color? borderColor,
  BorderRadius? borderRadius,
}) {
  if (top != null && (top < 0.0 || top > 1.0)) {
    throw ArgumentError('top value must be between 0.0 and 1.0');
  }
  OverlayState overlayState = Overlay.of(context);
  OverlayEntry? overlayEntry;
  overlayEntry = OverlayEntry(
    builder: (context) => SFAlert(
      top: top,
      left: left,
      right: right,
      height: height,
      heightSpacing: heightSpacing,
      status: status,
      title: title,
      titleLeading: titleLeading,
      closeWidget: closeWidget,
      titleTextStyle: titleTextStyle,
      content: content,
      padding: padding,
      contentTextStyle: contentTextStyle,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      borderRadius: borderRadius,
      onTap: () {
        overlayEntry?.remove();
      },
    ),
  );
  overlayState.insert(overlayEntry);
}
