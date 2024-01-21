import 'package:flutter/material.dart';

class SearchFilter extends StatelessWidget {
  const SearchFilter({super.key, this.margin = 25, required this.onChanged});

  final void Function(String)? onChanged;
  final double margin;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: margin, top: margin),
      child: TextFormField(
        decoration: InputDecoration(
            prefixIcon: InkWell(
              onTap: () {},
              child: const Icon(
                Icons.search,
                color: Color.fromARGB(255, 48, 48, 48),
              ), // Your icon
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
            filled: true,
            fillColor: const Color(0xFFF5F5F5),
            labelText: 'Search',
            labelStyle: Theme.of(context).textTheme.labelLarge,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            )),
        onChanged: onChanged,
      ),
    );
  }
}
