import 'package:flutter/material.dart';
import 'package:sfac_design_flutter/sfac_design_flutter.dart';
import 'package:sfac_design_flutter_example/select_menu.dart';

class SFSelectedMain extends StatefulWidget {
  const SFSelectedMain({
    super.key,
    required this.selectMenu,
    this.width,
    required this.height,
    this.backgroundColor,
    this.focusedBackgroundColor,
    this.outlineColor,
    this.radius = 10,
    this.outlineWidth,
    this.direction = Axis.vertical,
    this.onTap,
    this.margin,
    this.physics,
    this.heightSpacing = 10,
    this.focusedIndex = 0,
    this.downDuration,
  });
  final List<SFSelectMenu?> selectMenu;
  final double? width;
  final double height;
  final Color? backgroundColor;
  final Color? focusedBackgroundColor;
  final Color? outlineColor;
  final double radius;
  final double? outlineWidth;
  final Axis direction;
  final Function(int)? onTap;
  final EdgeInsetsGeometry? margin;
  final ScrollPhysics? physics;
  final double heightSpacing;
  final int focusedIndex;
  final Duration? downDuration;

  @override
  State<SFSelectedMain> createState() => _SelectedMainState();
}

class _SelectedMainState extends State<SFSelectedMain>
    with SingleTickerProviderStateMixin {
  int? focusedChild;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    focusedChild = widget.focusedIndex;
    _controller = AnimationController(
      duration: widget.downDuration ?? const Duration(milliseconds: 300),
      vsync: this,
    );

    _animation = Tween<double>(
      begin: 0.0,
      end: widget.height,
    ).animate(_controller);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return SizedBox(
              width: widget.width,
              height: _animation.value,
              child: ScrollConfiguration(
                behavior:
                    ScrollConfiguration.of(context).copyWith(scrollbars: false),
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  physics:
                      widget.physics ?? const NeverScrollableScrollPhysics(),
                  scrollDirection: widget.direction,
                  itemCount: widget.selectMenu.length,
                  itemBuilder: (context, index) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        onTap: () {
                          if (widget.onTap != null) {
                            widget.onTap!(index);
                          }
                          focusedChild = index;
                          setState(() {});
                        },
                        borderRadius: BorderRadius.all(
                          Radius.circular(widget.radius),
                        ),
                        hoverColor:
                            widget.focusedBackgroundColor ?? SFColor.primary5,
                        child: Container(
                          decoration: BoxDecoration(
                              color: focusedChild == index
                                  ? widget.focusedBackgroundColor ??
                                      SFColor.primary5
                                  : widget.backgroundColor,
                              border: Border.all(
                                  width: widget.outlineWidth ?? 0,
                                  color: widget.outlineColor ??
                                      Colors.transparent),
                              borderRadius:
                                  BorderRadius.circular(widget.radius)),
                          child: Padding(
                            padding: widget.margin ?? const EdgeInsets.all(8.0),
                            child: widget.selectMenu[index],
                          ),
                        ),
                      ),
                      SizedBox(height: widget.heightSpacing),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
