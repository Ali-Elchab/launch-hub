import 'package:flutter/material.dart';

class ChoiceTag extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onSelected;

  const ChoiceTag({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          color: !isSelected
              ? Theme.of(context).textTheme.labelLarge!.color
              : const Color(0xFF326789),
        ),
      ),
      selected: isSelected,
      showCheckmark: false,
      onSelected: (bool selected) {
        onSelected();
      },
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      selectedColor: const Color.fromARGB(255, 255, 255, 255),
      side: BorderSide(
        color: !isSelected
            ? const Color.fromARGB(34, 171, 171, 171)
            : const Color(0xFF326789),
        width: 1.6,
      ),
    );
  }
}
