import 'package:flutter/material.dart';
import 'package:launchhub_frontend/models/niche.dart';

class NicheDropDown extends StatelessWidget {
  final List<Niche> list;
  final Niche? value;
  final ValueChanged<Niche?> onChanged;
  const NicheDropDown({
    super.key,
    required this.list,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        filled: true,
        fillColor: const Color(0xFFF5F5F5),
        labelText: value == null ? '' : 'Sub Industry / Niche',
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        floatingLabelStyle: Theme.of(context).textTheme.labelLarge!.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: const Color(0xFF326789),
            ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<Niche>(
          borderRadius: BorderRadius.circular(10),
          icon: const Icon(Icons.arrow_drop_down,
              color: Color.fromARGB(255, 75, 75, 75)),
          value: value,
          isExpanded: true,
          onChanged: onChanged,
          hint: value == null
              ? const Text(
                  "Select Sub niche / Niche",
                  style: TextStyle(color: Color.fromARGB(255, 172, 172, 172)),
                )
              : null,
          items: list.map<DropdownMenuItem<Niche>>((Niche niche) {
            return DropdownMenuItem<Niche>(
              value: niche,
              child: Text(
                niche.name,
                style: const TextStyle(color: Colors.black),
              ),
            );
          }).toList(),
          dropdownColor: Colors.white,
        ),
      ),
    );
  }
}
