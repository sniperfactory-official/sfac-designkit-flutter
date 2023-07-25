import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SFTabBarView extends StatelessWidget {
  const SFTabBarView(
      {super.key,
      required this.tabController,
      required this.children,
      this.physics,
      this.dragStartBehavior,
      this.onPageChanged});

  // 페이지 컨트롤러
  final TabController tabController;

  // PageView body 리스트
  final List<Widget> children;

  // PageView ScrollPhysics
  final ScrollPhysics? physics;

  // PageView DragStartBehavior
  final DragStartBehavior? dragStartBehavior;

  // PageView onPageChanged
  final Function(int)? onPageChanged;

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      dragStartBehavior: dragStartBehavior ?? DragStartBehavior.start,
      controller: tabController,
      physics: physics ?? const ClampingScrollPhysics(),
      children: children,
    );
  }
}
