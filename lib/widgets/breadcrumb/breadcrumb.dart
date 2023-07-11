import 'package:flutter/material.dart';
import 'package:sfac_design_flutter/sfac_design_flutter.dart';

class SFBreadcrumb extends StatelessWidget {
  const SFBreadcrumb(
      {super.key, required this.menu, this.middleIcon, this.menuSpacing = 4});

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
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: menuSpacing),
                  child: e == menu.last
                      ? const SizedBox()
                      : middleIcon ??
                          const Icon(
                            Icons.play_arrow,
                            color: SfacColor.grayScale40,
                            size: 15,
                          ),
                )
              ],
            ),
          )
          .toList(),
    );
  }
}
