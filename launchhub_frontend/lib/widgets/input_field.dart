import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String label;
  final bool isPassword;

  const InputField({super.key, required this.label, this.isPassword = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: TextField(
        obscureText: isPassword,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
            filled: true,
            fillColor: const Color(0xFFF5F5F5),
            labelText: label,
            floatingLabelStyle:
                Theme.of(context).textTheme.labelLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: const Color(0xFF326789),
                    ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            )),
      ),
    );
  }
}
