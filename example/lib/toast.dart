import 'package:flutter/material.dart';
import 'package:sfac_design_flutter/widgets/toast/toast.dart';

class Toast extends StatelessWidget {
  const Toast({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.amber,
      child: Center(
        child: TextButton(
          child: Text('토스트'),
          onPressed: () {
            showToast(
              context,
              content: 'content',
              toastColor: Colors.white,
            );
          },
        ),
      ),
    );
  }
}
