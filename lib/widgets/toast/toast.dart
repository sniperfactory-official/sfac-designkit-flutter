import 'package:flutter/material.dart';
import 'package:sfac_design_flutter/sfac_design_flutter.dart';

enum SFToastStatus { withAction, withTitle, simple, error, success }

class SFToast extends StatefulWidget {
  const SFToast({
    super.key,
    this.top,
    this.left,
    this.right,
    required this.status,
    this.title,
    this.titleTextStyle,
    required this.content,
    this.contentPadding,
    this.contentTextStyle,
    this.contentColor,
    required this.toastColor,
    required this.borderColor,
    this.buttonText,
    this.buttonTextStyle,
    this.buttonPadding,
    this.buttonBorder,
    this.buttonColor,
    required this.onTap,
    this.toastRadius,
    this.toastDuration,
    this.animationDuration,
  });

  // Toast의 세로 축 위치를 지정, 0.0 부터 1.0까지 사용가능
  final double? top;

  // Toast의 왼쪽, 오른쪽 위치 값
  final double? left;
  final double? right;

  // Toast status로 withAction, withTitle, simple, error, success 사용 가능
  final SFToastStatus? status;

  // 굵은 글씨의 제목 부분으로 status가 SFToastStatus.withAction, SFToastStatus.withTitle일 때 출력 가능
  final String? title;

  // Title을 사용할 경우의 스타일 지정
  final TextStyle? titleTextStyle;

  // Toast 본문
  final String content;

  // Toast 내용의 padding 값
  final EdgeInsets? contentPadding;

  // Toast 본문 내용의 스타일 지정
  final TextStyle? contentTextStyle;

  // Toast 본문 내용의 컬러
  final Color? contentColor;

  // Toast 배경색, status가 success, error일 땐 사용불가
  final Color toastColor;

  // Toast 테두리 색, status가 success, error일 땐 사용불가
  final Color borderColor;

  // Button의 텍스트
  final String? buttonText;

  // Button 안의 텍스트 스타일
  final TextStyle? buttonTextStyle;

  // Button padding
  final EdgeInsets? buttonPadding;

  // Button Border
  final Border? buttonBorder;

  // Button 배경색
  final Color? buttonColor;

  // Toast의 borderRadius
  final BorderRadius? toastRadius;

  // Toast가 떠있는 시간, withAction을 제외한 상태에서 적용가능
  final Duration? toastDuration;

  // Toast가 사라지는 애니메이션의 시간
  // 0으로 설정할 경우 애니메이션 없이 바로 사라짐
  final Duration? animationDuration;

  // withAction의 버튼을 눌렀을 때 Toast가 사라지는 이벤트
  final VoidCallback onTap;

  @override
  State<SFToast> createState() => _SFToastState();
}

class _SFToastState extends State<SFToast> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration ?? const Duration(seconds: 1),
    );

    _opacityAnimation =
        Tween<double>(begin: 1.0, end: 0.0).animate(_animationController);

    _opacityAnimation.addListener(() {
      setState(() {});
    });

    void showToastAnimation() {
      if (widget.status != SFToastStatus.withAction) {
        Future.delayed(widget.toastDuration ?? const Duration(seconds: 3),
            () => _animationController.forward());
        _animationController.addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            widget.onTap.call();
          }
        });
      }
    }

    showToastAnimation();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isButtonEnabled = false;
    bool isTitleEnable = false;
    Color statusTextColor = SFColor.grayScale60;
    Color toastColor = widget.toastColor;
    Color borderColor = widget.borderColor;
    switch (widget.status) {
      case SFToastStatus.withAction:
        isButtonEnabled = true;
        isTitleEnable = true;
        break;
      case SFToastStatus.withTitle:
        isTitleEnable = true;
        break;
      case SFToastStatus.simple:
        break;
      case SFToastStatus.success:
        statusTextColor = SFColor.green;
        toastColor = const Color(0xffF4FBF5);
        borderColor = SFColor.green;
        break;
      case SFToastStatus.error:
        statusTextColor = SFColor.red;
        toastColor = const Color(0xffFFF4F4);
        borderColor = SFColor.red;
        break;
      default:
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
        child: Opacity(
          opacity: _opacityAnimation.value,
          child: Container(
            padding: widget.contentPadding ??
                const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  offset: Offset(3, 3),
                  color: Color.fromRGBO(206, 206, 206, 0.47),
                  blurRadius: 9,
                )
              ],
              color: toastColor,
              borderRadius: widget.toastRadius ?? BorderRadius.circular(10.0),
              border: Border.all(
                color: borderColor,
              ),
            ),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    isTitleEnable
                        ? Text(
                            widget.title ?? 'Title',
                            style: widget.titleTextStyle ??
                                SFTextStyle.b4B14(color: Colors.black),
                          )
                        : const SizedBox.shrink(),
                    Text(
                      widget.content,
                      style: widget.contentTextStyle ??
                          SFTextStyle.b5R12(
                              color: widget.contentColor ?? statusTextColor),
                    )
                  ],
                ),
                const Spacer(),
                isButtonEnabled
                    ? GestureDetector(
                        onTap: widget.onTap,
                        child: Container(
                          padding: widget.buttonPadding ??
                              const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: widget.buttonColor ?? SFColor.primary5,
                            border: widget.buttonBorder ??
                                Border.all(
                                  color: SFColor.primary40,
                                ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            widget.buttonText ?? '확인',
                            style: widget.buttonTextStyle ??
                                const TextStyle(color: SFColor.primary40),
                          ),
                        ),
                      )
                    : const SizedBox.shrink()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void showToast(
  BuildContext context, {
  double? top,
  double? left,
  double? right,
  SFToastStatus status = SFToastStatus.simple,
  String? title,
  TextStyle? titleTextStyle,
  required String content,
  EdgeInsets? contentPadding,
  TextStyle? contentTextStyle,
  Color? contentColor,
  Color toastColor = Colors.white,
  Color borderColor = SFColor.grayScale10,
  String? buttonText,
  TextStyle? buttonTextStyle,
  EdgeInsets? buttonPadding,
  Border? buttonBorder,
  Color? buttonColor,
  BorderRadius? toastRadius,
  Duration? toastDuration,
  Duration? animationDuration,
}) {
  if (top != null && (top < 0.0 || top > 1.0)) {
    throw ArgumentError('top value must be between 0.0 and 1.0');
  }
  OverlayState overlayState = Overlay.of(context);
  OverlayEntry? overlayEntry;
  overlayEntry = OverlayEntry(
    builder: (context) => SFToast(
      top: top,
      left: left,
      right: right,
      status: status,
      title: title,
      titleTextStyle: titleTextStyle,
      content: content,
      contentPadding: contentPadding,
      contentTextStyle: contentTextStyle,
      contentColor: contentColor,
      toastColor: toastColor,
      borderColor: borderColor,
      buttonText: buttonText,
      buttonTextStyle: buttonTextStyle,
      buttonPadding: buttonPadding,
      buttonBorder: buttonBorder,
      buttonColor: buttonColor,
      toastRadius: toastRadius,
      toastDuration: toastDuration,
      animationDuration: animationDuration,
      onTap: () {
        overlayEntry?.remove();
      },
    ),
  );
  overlayState.insert(overlayEntry);
}
