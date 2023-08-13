import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sfac_design_flutter/sfac_design_flutter.dart';
import 'package:sfac_design_flutter/widgets/radio/radio.dart';
import 'package:sfac_design_flutter/widgets/radio/radio_button.dart';
import 'package:sfac_design_flutter/widgets/searchfield/searchfield.dart';

void main() {
  runApp(const MyApp());
}

enum Gender { male, female }

enum Region { seoul, other }

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Gender? gender;
  Region? region;
  selectGender(val) {
    print(val);
    setState(() {
      gender = val;
    });
  }

  selectRegion(val) {
    setState(() {
      region = val;
    });
  }

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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SFRadio(
                      groupValue: gender,
                      onChanged: (value) {
                        selectGender(value);
                      },
                      value: Gender.male,
                    ),
                    SFRadio(
                      groupValue: gender,
                      onChanged: (value) {
                        selectGender(value);
                      },
                      value: Gender.female,
                    ),
                  ],
                ),
                Text('$gender'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SFRadio(
                      groupValue: region,
                      onChanged: (value) {
                        selectRegion(value);
                      },
                      value: Region.seoul,
                    ),
                    SFRadio(
                      groupValue: region,
                      onChanged: (value) {
                        selectRegion(value);
                      },
                      value: Region.other,
                    ),
                  ],
                ),
                Text('$region'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
