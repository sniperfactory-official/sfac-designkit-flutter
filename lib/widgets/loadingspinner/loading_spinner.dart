import 'package:flutter/material.dart';
import '../../util/sfac_color.dart';
import 'dart:math' as math;

class SFLoadingSpinner extends StatefulWidget {
  SFLoadingSpinner({
    Key? key,
    this.strokeWidth = 2,
    this.color = SFColor.primary100,
    this.size = 16,
    this.duration = const Duration(seconds: 2),
  }) : super(key: key);

  // 원의 두께
  final double strokeWidth;

  // 원의 색상
  final Color color;

  // 원의 크기
  final double size;

  // 애니메이션 시간
  final Duration duration;

  @override
  SFLoadingSpinnerState createState() => SFLoadingSpinnerState();
}

class SFLoadingSpinnerState extends State<SFLoadingSpinner>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size * math.pi,
      height: widget.size * math.pi,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.rotate(
            angle: _controller.value * 2 * math.pi,
            child: CustomPaint(
              painter: _CustomProgressPainter(
                strokeWidth: widget.strokeWidth,
                color: widget.color,
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class _CustomProgressPainter extends CustomPainter {
  static const double startAngle = -math.pi / 2;
  static const double sweepAngle = math.pi * 1.5;
  final double strokeWidth;
  final Color color;

  _CustomProgressPainter({
    required this.strokeWidth,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double radius = size.width / 2;

    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final Offset center = Offset(size.width / 2, size.height / 2);

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
