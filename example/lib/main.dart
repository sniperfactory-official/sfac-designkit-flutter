import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sfac_design_flutter/sfac_design_flutter.dart';
import 'package:sfac_design_flutter/widgets/loadingspinner/loading_spinner.dart';
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: const SFLoadingSpinner(
                    color: Colors.amber,
                    duration: Duration(seconds: 4),
                    size: 120,
                    strokeWidth: 24,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
