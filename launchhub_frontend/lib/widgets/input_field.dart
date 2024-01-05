import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String label;
  final bool isPassword;
  final bool isDescription;
  final String? Function(String?)? validator;
  final AutovalidateMode autovalidateMode;
  const InputField({
    super.key,
    required this.label,
    this.isPassword = false,
    this.isDescription = false,
    this.validator,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        obscureText: isPassword,
        validator: validator,
        autovalidateMode: autovalidateMode,
        maxLines: isDescription ? 4 : 1, // Allows expanding vertically
        minLines: isDescription ? 4 : 1, // Sets a minimum height for the field
        keyboardType: isPassword ? TextInputType.text : TextInputType.multiline,
        scrollPhysics: const BouncingScrollPhysics(), // Smooth scrolling
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
