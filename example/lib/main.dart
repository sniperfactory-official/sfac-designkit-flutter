// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sfac_design_flutter/sfac_design_flutter.dart';
import 'package:sfac_design_flutter/widgets/tabs/tab.dart';
import 'package:sfac_design_flutter/widgets/tabs/tabar_view.dart';
import 'package:sfac_design_flutter_example/combo_box.dart';
import 'package:sfac_design_flutter_example/select_menu.dart';
import 'package:sfac_design_flutter_example/selected_main.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    print(tabController.length);
    return MaterialApp(
      title: 'SFAC Widget',
      home: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SFTabBar(
                menu: [Text('data'), Text('acc')],
                height: 50,
                pageController: tabController,
              ),
              SizedBox(
                height: 500,
                child: SFTabBarView(
                  tabController: tabController,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      color: Colors.amber,
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      color: Colors.blue,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
