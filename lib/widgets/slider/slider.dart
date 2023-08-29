import 'package:flutter/material.dart';
import 'package:sfac_design_flutter/sfac_design_flutter.dart';

class SFSlider extends StatefulWidget {
  const SFSlider(
      {super.key,
      required this.onChanged,
      this.width,
      this.thumbSize = 20,
      this.thumbWidth = 4,
      required this.percentValue,
      this.height = 12})
      : assert(percentValue >= 0 && percentValue <= 100,
            'Values must be between 0 and 100!'),
        assert(height == null || height <= thumbSize,
            'height must be less than or equal to thumbSize'),
        assert(thumbWidth <= thumbSize / 2,
            'thumbWidth must be less than or equal to half of thumbSize');

  // 슬라이더 값이 변경될 때 호출되는 콜백
  final Function(int value) onChanged;

  // 슬라이드 너비
  final double? width;

  // 원 사이즈
  final double thumbSize;

  // 원 테두리 두께
  final double thumbWidth;

  // 슬라이드 수치
  final int percentValue;

  // 슬라이드 높이
  final double? height;

  @override
  SFSliderState createState() => SFSliderState();
}

class SFSliderState extends State<SFSlider> {
  late double sliderValue;

  void _onDragUpdate(double newValue) {
    setState(() {
      sliderValue = newValue;
    });
    int intValue = (sliderValue * 100).toInt();
    if (intValue >= 0 && intValue <= 100) {
      widget.onChanged(intValue);
    }
  }

  @override
  void initState() {
    super.initState();
    sliderValue = widget.percentValue.toDouble() / 100;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = widget.width ?? constraints.maxWidth;
        return SizedBox(
          width: width,
          height: widget.thumbSize,
          child: GestureDetector(
            onHorizontalDragUpdate: (details) {
              RenderBox box = context.findRenderObject() as RenderBox;
              double localDx = box.globalToLocal(details.globalPosition).dx;
              double newValue = (localDx / (box.size.width - widget.thumbSize))
                  .clamp(0.0, 1.0);
              _onDragUpdate(newValue);
            },
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: widget.height,
                    margin:
                        EdgeInsets.symmetric(horizontal: widget.thumbSize / 2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(999),
                      color: SFColor.grayScale20,
                    ),
                  ),
                ),
                Positioned(
                  left: widget.thumbSize / 2,
                  top: 0,
                  bottom: 0,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: sliderValue * (width - widget.thumbSize),
                      height: widget.height,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(999),
                          bottomLeft: Radius.circular(999),
                        ),
                        color: SFColor.primary80,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: sliderValue * (width - widget.thumbSize),
                  top: 0,
                  bottom: 0,
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: widget.thumbSize,
                      height: widget.thumbSize,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: SFColor.primary80,
                          width: widget.thumbWidth,
                        ),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Center(
                        child: Container(
                          width: widget.thumbSize - 1,
                          height: widget.thumbSize - 1,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(999),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
