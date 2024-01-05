import 'package:flutter/material.dart';

class SocialSignInButton extends StatelessWidget {
  final String text;
  final String imagePath;
  final VoidCallback onPressed;

  const SocialSignInButton({
    super.key,
    required this.text,
    required this.imagePath,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: const Color(0xFFF5F5F5),
          side: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
          alignment:
              Alignment.centerLeft, // Aligns content to the left of the button
        ),
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.start, // Align items to the start
          children: [
            Image.asset(imagePath, height: 24), // Social logo here
            const SizedBox(
                width: 8), // Provides a gap between the image and text
            Expanded(
              child: Text(text,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: const Color.fromARGB(204, 0, 0, 0),
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      )),
            ),
          ],
        ),
      ),
    );
  }
}
