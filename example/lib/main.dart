import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sfac_design_flutter/sfac_design_flutter.dart';
import 'package:sfac_design_flutter/widgets/searchfield/searchfield.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SFAC Widget',
      home: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    const SFAvatar(
                      backgroundColor: Colors.white,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      '스나이퍼팩토리 디자인시스템',
                      style: SFTextStyle.b2B18(),
                    )
                  ],
                ),
                const SFCard(
                  margin: EdgeInsets.symmetric(vertical: 4),
                  title: Text('Badge'),
                  verticalSpacing: 8,
                  content: Row(
                    children: [
                      SFBadge(
                        child: Text(
                          'primary',
                        ),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      SFBadge(
                        status: SFBadgeStatus.secondary,
                        child: Text(
                          'secondary',
                        ),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      SFBadge(
                        status: SFBadgeStatus.outline,
                        child: Text(
                          'outline',
                        ),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      SFBadge(
                        status: SFBadgeStatus.destructive,
                        child: Text(
                          'destructive',
                        ),
                      ),
                    ],
                  ),
                ),
                SFCard(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  verticalSpacing: 8,
                  title: const Text('Button'),
                  content: Column(
                    children: [
                      SFButton(
                        onPressed: () {},
                        child: const Text('primary'),
                      ),
                      const SizedBox(height: 8),
                      SFButton(
                        status: SFButtonStatus.secondary,
                        onPressed: () {},
                        child: const Text('secondary'),
                      ),
                      const SizedBox(height: 8),
                      SFButton(
                        status: SFButtonStatus.outline,
                        onPressed: () {},
                        child: const Text('outline'),
                      ),
                      const SizedBox(height: 8),
                      SFButton(
                        status: SFButtonStatus.destructive,
                        onPressed: () {},
                        child: const Text('destructive'),
                      ),
                      const SizedBox(height: 8),
                      SFButton(
                        status: SFButtonStatus.link,
                        onPressed: () {},
                        child: const Text('link'),
                      ),
                      const SizedBox(height: 8),
                      SFButton(
                        status: SFButtonStatus.disabled,
                        onPressed: () {},
                        child: const Text('disabled'),
                      ),
                      const SizedBox(height: 8),
                      SFButton(
                        status: SFButtonStatus.asChild,
                        onPressed: () {},
                        child: const Text('asChild'),
                      ),
                    ],
                  ),
                ),
                const SFCard(
                  margin: EdgeInsets.symmetric(vertical: 4),
                  title: Text('Search Field'),
                  content: SFSearchField(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
