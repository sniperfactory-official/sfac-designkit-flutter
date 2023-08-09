import 'package:flutter/material.dart';
import 'package:sfac_design_flutter/widgets/pagination/pagination.dart';
import 'package:sfac_design_flutter_example/page/page1.dart';
import 'package:sfac_design_flutter_example/page/page2.dart';
import 'package:sfac_design_flutter_example/page/page3.dart';
import 'package:sfac_design_flutter_example/page/page4.dart';
import 'package:sfac_design_flutter_example/page/page5.dart';
import 'package:sfac_design_flutter_example/page/page6.dart';
import 'package:sfac_design_flutter_example/page/page7.dart';

class PageScreen extends StatefulWidget {
  const PageScreen({super.key});

  @override
  State<PageScreen> createState() => _PageScreenState();
}

class _PageScreenState extends State<PageScreen> {
  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
        body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            FirstPage(),
            SecondPage(),
            Page3(),
            Page4(),
            Page5(),
            Page6(),
            Page7(),
          ],
        ),
        bottomNavigationBar: SFPagination(
          totalPage: 7,
          currentPage: 1,
          itemsPerPage: 5,
          pageController: _pageController,
        )
    );
  }
}