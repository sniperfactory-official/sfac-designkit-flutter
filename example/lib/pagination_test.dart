import 'package:flutter/material.dart';
import 'package:sfac_design_flutter_example/pagescreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SFAC Widget',
      home: PageScreen()
    );
  }
}
