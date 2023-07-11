import 'package:flutter/material.dart';
import 'package:sfac_design_flutter/sfac_design_flutter.dart';

class SFBreadcrumb extends StatelessWidget {
  const SFBreadcrumb(
      {super.key, required this.menu, this.middleIcon, this.menuSpacing = 10});

  // 메뉴 문자열 리스트
  final List<String> menu;

  // 메뉴 사이 사이 아이콘
  final Widget? middleIcon;

  // 메뉴와 아이콘 사이 간격
  final double menuSpacing;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: menu
          .map(
            (e) => Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  e,
                  style: SfacTextStyle.b2M18(color: SfacColor.grayScale80),
                ),
                SizedBox(width: menuSpacing / 2),
                e == menu.last
                    ? const SizedBox()
                    : middleIcon ??
                        const Icon(
                          Icons.play_arrow,
                          color: SfacColor.grayScale40,
                          size: 15,
                        ),
                SizedBox(width: menuSpacing / 2),
              ],
            ),
          )
          .toList(),
    );
  }
}
