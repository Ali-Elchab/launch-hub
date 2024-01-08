import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  final String label;
  final bool isPassword;
  final bool isDescription;
  final String? Function(String?)? validator;
  final AutovalidateMode autovalidateMode;
  final TextEditingController? controller;
  final bool readOnly;
  final VoidCallback? onTap;
  final Widget? icon;
  const InputField({
    super.key,
    this.controller,
    required this.label,
    this.isPassword = false,
    this.isDescription = false,
    this.readOnly = false,
    this.onTap,
    this.icon,
    this.validator,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
  });

  @override
  // ignore: library_private_types_in_public_api
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool isFocused = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      // alignment: Alignment.topLeft,
      child: TextFormField(
        style: Theme.of(context).textTheme.bodyLarge,
        controller: widget.controller,
        readOnly: widget.readOnly,
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
          floatingLabelStyle: Theme.of(context).textTheme.labelMedium!.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
                // height: 25,
                letterSpacing: 0.5,
              ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              width: 1,
              color: isFocused
                  ? Theme.of(context).colorScheme.primary
                  : Colors.transparent,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              width: 1,
              color: Colors.transparent,
            ),
          ),
          suffixIcon: widget.icon,
        ),
        onChanged: (value) {
          setState(() {
            isFocused = true;
          });
        },
        onTap: widget.onTap,
      ),
    );
  }
}
