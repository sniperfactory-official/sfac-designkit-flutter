// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sfac_design_flutter/sfac_design_flutter.dart';
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

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SFAC Widget',
      home: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SFComboBox(selectMenu: [
                SFSelectMenu(text: 'g'),
                SFSelectMenu(text: '(text)')
              ], height: 20)
            ],
          ),
        ),
      ),
    );
  }
}
