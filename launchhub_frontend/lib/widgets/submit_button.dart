import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton(this.text, this.onPressed, {super.key});
  final String text;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        child: Text(
          text,
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              color: const Color.fromARGB(255, 255, 255, 255),
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ),
      ),
    );
  }
}
