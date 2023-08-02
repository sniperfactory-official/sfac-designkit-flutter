import 'package:flutter/material.dart';
import 'package:sfac_design_flutter/widgets/toast/toast.dart';

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      color: Colors.amber,
      child: TextButton(
        child: Text('asd'),
        onPressed: () {
          showToast(
            context,
            content: 'content',
          );
        },
      ),
    );
  }
}
