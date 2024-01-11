import 'package:flutter/material.dart';

class WelcomeCard extends StatelessWidget {
  final String imageUrl;
  final String text;

  const WelcomeCard({super.key, required this.imageUrl, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 160,
          width: 110,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 25),
        Expanded(
          child: Text(text,
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.bodyMedium!),
        ),
      ],
    );
  }
}
