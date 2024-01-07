import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  final String label;
  final bool isPassword;
  final bool isDescription;
  final String? Function(String?)? validator;
  final AutovalidateMode autovalidateMode;
  final TextEditingController? controller;

  const InputField({
    super.key,
    this.controller,
    required this.label,
    this.isPassword = false,
    this.isDescription = false,
    this.validator,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
  });

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool isFocused = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        obscureText: widget.isPassword,
        validator: widget.validator,
        autovalidateMode: widget.autovalidateMode,
        maxLines: widget.isDescription ? 4 : 1,
        minLines: widget.isDescription ? 4 : 1,
        keyboardType:
            widget.isPassword ? TextInputType.text : TextInputType.multiline,
        scrollPhysics: const BouncingScrollPhysics(),
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          filled: true,
          fillColor: const Color(0xFFF5F5F5),
          labelText: widget.label,
          labelStyle: Theme.of(context).textTheme.labelMedium!,
          alignLabelWithHint: true,
          floatingLabelStyle: Theme.of(context).textTheme.labelLarge!.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: const Color(0xFF326789),
                height: 25,
                letterSpacing: 0.5,
              ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              width: 1,
              color: isFocused ? Colors.blue : Colors.transparent,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              width: 1,
              color: Colors.transparent,
            ),
          ),
        ),
        onChanged: (value) {
          setState(() {
            isFocused = true;
          });
        },
      ),
    );
  }
}
