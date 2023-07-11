import 'package:flutter/material.dart';
import 'package:sfac_design_flutter/sfac_design_flutter.dart';

class SFBreadcrumb extends StatelessWidget {
  const SFBreadcrumb(
      {super.key,
      required this.menu,
      this.middleIcon,
      this.width,
      required this.height,
      this.physics,
      this.spacing = 10});

  // Breadcrumb 메뉴 문자열 리스트
  final List<String> menu;

  // 메뉴 사이사이 아이콘
  final Widget? middleIcon;

  // 위젯 가로 넓이
  final double? width;

  // 위젯 높이
  final double height;

  // 스크롤 physics
  final ScrollPhysics? physics;

  // 메뉴와 아이콘 사이 간격
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ListView.builder(
        physics: physics ?? const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: menu.length,
        itemBuilder: (context, index) => Row(
          children: [
            Text(
              menu[index],
              style: SfacTextStyle.b2M18(color: SfacColor.grayScale80),
            ),
            SizedBox(width: spacing / 2),
            index == menu.length - 1
                ? const SizedBox()
                : middleIcon ??
                    const Icon(
                      Icons.play_arrow,
                      color: SfacColor.grayScale40,
                      size: 15,
                    ),
            SizedBox(width: spacing / 2),
          ],
        ),
      ),
    );
  }
}
