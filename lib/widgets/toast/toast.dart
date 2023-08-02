import 'package:flutter/material.dart';
import 'package:sfac_design_flutter/sfac_design_flutter.dart';

enum SFToastStatus { withAction, withTitle, simple, error, success }

class SFToast extends StatefulWidget {
  const SFToast(
      {super.key,
      required this.content,
      this.title,
      this.status,
      this.contentPadding,
      this.top,
      this.left,
      this.right,
      this.textColor,
      required this.onTap,
      this.toastRadius,
      this.toastDuration,
      this.animationDuration});

  // 굵은 글씨의 제목 부분으로 status가 SFToastStatus.withAction, SFToastStatus.withTitle일 때 출력 가능
  final String? title;

  // Toast 본문
  final String? content;

  // Toast status로 withAction, withTitle, simple, error, success 사용 가능
  final SFToastStatus? status;

  // Toast 내용의 padding 값
  final EdgeInsets? contentPadding;

  // Toast의 세로 축 위치를 지정, 0.0 부터 1.0까지 사용가능
  final double? top;

  // Toast의 왼쪽, 오른쪽 위치 값
  final double? left;
  final double? right;

  // Toast 본문 내용의 컬러
  final Color? textColor;

  // withAction의 버튼을 눌렀을 때 Toast가 사라지는 이벤트
  final VoidCallback onTap;

  // Toast의 borderRadius
  final BorderRadius? toastRadius;

  // Toast가 떠있는 시간, withAction을 제외한 상태에서 적용가능
  final Duration? toastDuration;

  // Toast가 사라지는 애니메이션의 시간
  // 0으로 설정할 경우 애니메이션 없이 바로 사라짐
  final Duration? animationDuration;

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
    Color? borderColor;
    Color? toastColor;
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
        borderColor = SFColor.green;
        toastColor = const Color(0xffF4FBF5);
        break;
      case SFToastStatus.error:
        statusTextColor = SFColor.red;
        borderColor = SFColor.red;
        toastColor = const Color(0xffFFF4F4);
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
              color: toastColor ?? Colors.white,
              borderRadius: widget.toastRadius ?? BorderRadius.circular(10.0),
              border: Border.all(
                color: borderColor ?? SFColor.grayScale10,
              ),
            ),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    isTitleEnable
                        ? Text(
                            widget.title!,
                            style: SFTextStyle.b4B14(color: Colors.black),
                          )
                        : const SizedBox.shrink(),
                    Text(
                      widget.content!,
                      style: SFTextStyle.b5R12(
                          color: widget.textColor ?? statusTextColor),
                    )
                  ],
                ),
                const Spacer(),
                isButtonEnabled
                    ? GestureDetector(
                        onTap: widget.onTap,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: const Color(0xffF5F8FF),
                            border: Border.all(
                              color: const Color(0xff99BDFF),
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            '확인',
                            style: TextStyle(
                              color: Color(0xff99BDFF),
                            ),
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
  String? title,
  required String? content,
  SFToastStatus status = SFToastStatus.simple,
  EdgeInsets? contentPadding,
  double? top,
  double? left,
  double? right,
  Color? textColor,
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
        title: title,
        content: content,
        status: status,
        contentPadding: contentPadding,
        top: top,
        left: left,
        right: right,
        textColor: textColor,
        toastRadius: toastRadius,
        toastDuration: toastDuration,
        animationDuration: animationDuration,
        onTap: () {
          overlayEntry?.remove();
        }),
  );
  overlayState.insert(overlayEntry);
}
