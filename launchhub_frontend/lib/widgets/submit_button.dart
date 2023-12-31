import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton(this.text, this.onPressed, {super.key});
  final String text;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 260,
      child: ElevatedButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: const Color(0xFF326789),
        ),
        child: Text(
          text,
          style: const TextStyle(
              color: Colors.white,
              fontFamily: 'inter',
              fontSize: 14,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
