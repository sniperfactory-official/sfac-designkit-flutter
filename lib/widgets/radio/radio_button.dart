import 'package:flutter/material.dart';

class SFRadioButton extends StatefulWidget {
  const SFRadioButton({super.key});

  @override
  State<SFRadioButton> createState() => _SFRadioButtonState();
}

enum Gender { male, female }

enum Region { seoul, other }

class _SFRadioButtonState extends State<SFRadioButton> {
  Gender? gender;
  Region? region;
  selectGender(val) {
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
    print(gender);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Radio(
              groupValue: gender,
              onChanged: (gender) {
                print(gender);
                selectGender(gender);
              },
              value: Gender.male,
            ),
            Radio(
              groupValue: gender,
              onChanged: (gender) {
                selectGender(gender);
              },
              value: Gender.female,
            ),
          ],
        ),
        Text(gender == Gender.male
            ? '남성'
            : gender == Gender.female
                ? '여성'
                : '성별을 선택해주세요.'),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Radio(
              groupValue: region,
              onChanged: (region) {
                selectRegion(region);
              },
              value: Region.seoul,
            ),
            Radio(
              groupValue: region,
              onChanged: (region) {
                selectRegion(region);
              },
              value: Region.other,
            ),
          ],
        ),
        Text(region == Region.seoul
            ? '서울'
            : region == Region.other
                ? '서울 외 지역'
                : '지역을 선택해주세요.'),
      ],
    );
  }
}
