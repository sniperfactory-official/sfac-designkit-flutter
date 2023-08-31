// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class SFSkeleton extends StatefulWidget {
  const SFSkeleton({
    Key? key,
    required this.child,
    this.basicColor = Colors.grey,
    this.gradientColor = Colors.white,
    this.curve = Curves.fastOutSlowIn,
    this.duration = 4000,
    this.gradientSize = 2,
    this.gradientIncline = false,
  }) : super(key: key);

  // Skeleton으로 사용할 위젯
  final Widget child;

  // Skeleton 위젯 색상
  final Color basicColor;

  // 그라데이션 색상
  final Color gradientColor;

  // 그라데이션 크기
  final double gradientSize;

  // 그라데이션 기울기
  final bool gradientIncline;

  // 애니메이션 Curve 값
  final Curve curve;

  // 애니메이션 재생시간
  final int duration;

  @override
  SFSkeletonState createState() => SFSkeletonState();
}

class SFSkeletonState extends State<SFSkeleton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.duration),
    );

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        widget.child,
        AnimatedBuilder(
          animation: _controller,
          builder: (BuildContext context, Widget? child) {
            return Positioned.fill(
                child: ShaderMask(
              shaderCallback: (Rect rect) {
                final Animation<double> curveAnimation = CurvedAnimation(
                  parent: _controller,
                  curve: Curves.fastOutSlowIn,
                );
                final double dx = rect.width * curveAnimation.value;
                final Gradient gradient = LinearGradient(
                  begin: Alignment(
                      -widget.gradientSize, widget.gradientIncline ? 0.5 : 0),
                  end: Alignment(widget.gradientSize, 0),
                  colors: [
                    widget.basicColor,
                    widget.basicColor,
                    widget.gradientColor,
                    widget.basicColor,
                    widget.basicColor,
                  ],
                  stops: const [
                    0.0,
                    0.35,
                    0.5,
                    0.65,
                    1.0,
                  ],
                );
                return gradient.createShader(Rect.fromLTWH(
                  dx * 2,
                  0,
                  -rect.width,
                  rect.height,
                ));
              },
              blendMode: BlendMode.srcIn,
              child: widget.child,
            ));
          },
        ),
      ],
    );
  }
}
