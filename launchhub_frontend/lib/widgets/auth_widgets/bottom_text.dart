import 'package:flutter/material.dart';

class BottomText extends StatelessWidget {
  final String text;
  const BottomText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Text(
        text,
        textAlign: TextAlign.left,
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
            fontWeight: FontWeight.w100, fontSize: 11, color: Colors.grey),
      ),
    );
  }
}
