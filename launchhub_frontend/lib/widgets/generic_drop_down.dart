import 'package:flutter/material.dart';
import 'package:launchhub_frontend/models/industry.dart';

class GenericDropdown<T> extends StatelessWidget {
  final String label;
  final List<T> options;
  final T? selectedOption;
  final String Function(T?) optionLabel;
  final void Function(T?) onChanged;
  final String? Function(Industry?)? validator;
  final AutovalidateMode autovalidateMode;

  const GenericDropdown({
    super.key,
    required this.label,
    required this.options,
    required this.selectedOption,
    required this.optionLabel,
    required this.onChanged,
    this.validator,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xFFF5F5F5),
      ),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: selectedOption != null ? label : null,
          // floatingLabelBehavior: FloatingLabelBehavior.auto,
          floatingLabelStyle: Theme.of(context).textTheme.labelMedium!.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 00),
          alignLabelWithHint: true,
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<T>(
              style: Theme.of(context).textTheme.bodyLarge,
              borderRadius: BorderRadius.circular(10),
              isExpanded: true,
              icon: const Icon(Icons.arrow_drop_down,
                  color: Color.fromARGB(255, 75, 75, 75)),
              value: selectedOption,
              onChanged: onChanged,
              items: [
                DropdownMenuItem<T>(
                  value: null,
                  child: Text(label,
                      style: Theme.of(context).textTheme.labelMedium!),
                ),
                ...options.map((T option) {
                  return DropdownMenuItem<T>(
                    value: option,
                    child: Text(optionLabel(option)),
                  );
                })
              ]),
        ),
      ),
    );
  }
}
