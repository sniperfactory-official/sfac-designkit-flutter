import 'package:flutter/material.dart';

import 'package:sfac_design_flutter/sfac_design_flutter.dart';

class SFAlertDialog extends StatefulWidget {
  const SFAlertDialog({
    Key? key,
    this.top,
    this.left,
    this.right,
    this.height,
    this.heightSpacing,
    required this.title,
    this.titleLeading,
    this.closeWidget,
    this.titleTextStyle,
    required this.content,
    this.padding,
    this.contentTextStyle,
    this.backgroundColor,
    this.borderColor,
    this.borderRadius,
    required this.remove,
    this.acceptButtonText,
    this.cancleButtonText,
    this.onAccept,
    this.onCancle,
  }) : super(key: key);

  // alert의 세로 축 위치를 지정, 0.0 부터 1.0까지 사용가능
  final double? top;

  // alert의 왼쪽, 오른쪽 여백 값
  final double? left;
  final double? right;

  // alert의 높이
  final double? height;

  // title과 content의 사이 간격
  final double? heightSpacing;

  // alert의 title, laeding과 trailing 사이에서 최대너비를 가진다
  final String title;

  // title의 laeding 위젯 위젯이 있을 시 title과 8의 간격이 있다
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

  // alert remove 기능
  final VoidCallback remove;

  // accept button에 들어갈 텍스트
  final String? acceptButtonText;

  // cancle button에 들어갈 텍스트
  final String? cancleButtonText;

  // accept button을 눌렀을 때 실행할 콜백함수
  final VoidCallback? onAccept;

  // cancle button을 눌렀을 때 실행할 콜백함수
  final VoidCallback? onCancle;
  @override
  State<SFAlertDialog> createState() => _SFAlertDialogState();
}

class _SFAlertDialogState extends State<SFAlertDialog>
    with SingleTickerProviderStateMixin {
  Widget? _titleLeading;

  @override
  Widget build(BuildContext context) {
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
            color: widget.backgroundColor ?? Colors.white,
            borderRadius: widget.borderRadius ?? BorderRadius.circular(10.0),
            border: Border.all(
              color: widget.borderColor ?? SFColor.grayScale10,
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
                    SizedBox(width: _titleLeading != null ? 8 : 0),
                    Expanded(
                      child: Text(
                        widget.title,
                        style: widget.titleTextStyle ??
                            SFTextStyle.b4B14(
                              color: SFColor.grayScale80,
                            ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: widget.heightSpacing),
                Text(
                  widget.content,
                  style: widget.contentTextStyle ??
                      SFTextStyle.b5M12(
                        color: SFColor.grayScale60,
                      ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(10.0), // 원하는 모서리 반지름 값 설정
                        ),
                        backgroundColor: SFColor.grayScale5,
                      ),
                      onPressed: () {
                        widget.remove();
                        widget.onCancle != null ? widget.onCancle!() : null;
                      },
                      child: Text(
                        widget.cancleButtonText ?? 'cancle',
                        style: TextStyle(color: SFColor.grayScale60),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(10.0), // 원하는 모서리 반지름 값 설정
                        ),
                        backgroundColor: SFColor.primary80,
                      ),
                      onPressed: () {
                        widget.remove();
                        widget.onAccept != null ? widget.onAccept!() : null;
                      },
                      child: Text(widget.acceptButtonText ?? 'accept'),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void alertDialog(
  BuildContext context, {
  double? top,
  double? left,
  double? right,
  double? height,
  double? heightSpacing = 4,
  required String title,
  Widget? titleLeading,
  TextStyle? titleTextStyle,
  required String content,
  EdgeInsets? padding,
  TextStyle? contentTextStyle,
  Color? backgroundColor,
  Color? borderColor,
  BorderRadius? borderRadius,
  String? cancleButtonText,
  String? acceptButtonText,
  VoidCallback? onCancle,
  VoidCallback? onAccept,
}) {
  if (top != null && (top < 0.0 || top > 1.0)) {
    throw ArgumentError('top value must be between 0.0 and 1.0');
  }
  OverlayState overlayState = Overlay.of(context);
  OverlayEntry? overlayEntry;
  overlayEntry = OverlayEntry(
    builder: (context) => SFAlertDialog(
      top: top,
      left: left,
      right: right,
      height: height,
      heightSpacing: heightSpacing,
      title: title,
      titleLeading: titleLeading,
      titleTextStyle: titleTextStyle,
      content: content,
      padding: padding,
      contentTextStyle: contentTextStyle,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      borderRadius: borderRadius,
      remove: () {
        overlayEntry?.remove();
      },
      acceptButtonText: acceptButtonText,
      cancleButtonText: cancleButtonText,
      onAccept: onAccept,
      onCancle: onCancle,
    ),
  );
  overlayState.insert(overlayEntry);
}
