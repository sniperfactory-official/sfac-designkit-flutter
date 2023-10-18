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
              children: [TTTT()],
            ),
          ),
        ),
      ),
    );
  }
}

class TTTT extends StatelessWidget {
  const TTTT({super.key});

  @override
  Widget build(BuildContext context) {
    return SFDatePicker(
        type: SFCalendarType.range,
        getSelectedDate: (start, end, selectedDateList, selectedOne) {
          alertDialog(context, title: 'title', content: 'content');
        });
  }
}
