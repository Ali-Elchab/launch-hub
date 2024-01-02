import 'package:flutter/material.dart';

class BottomText extends StatelessWidget {
  const BottomText({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Text(
        'This information will be showcased to job seekers, helping them make informed decisions about opportunities with your company.',
        textAlign: TextAlign.left,
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
            fontWeight: FontWeight.w100, fontSize: 11, color: Colors.grey),
      ),
    );
  }
}
