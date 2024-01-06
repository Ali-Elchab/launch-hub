import 'package:flutter/material.dart';

class SearchInput extends StatelessWidget {
  const SearchInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      child: TextFormField(
        // obscureText: isPassword,
        // validator: validator,
        // autovalidateMode: autovalidateMode,
        // maxLines: isDescription ? 4 : 1, // Allows expanding vertically
        // minLines: isDescription ? 4 : 1, // Sets a minimum height for the field
        // keyboardType: isPassword ? TextInputType.text : TextInputType.multiline,
        scrollPhysics: const BouncingScrollPhysics(), // Smooth scrolling
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
            filled: true,
            fillColor: const Color(0xFFF5F5F5),
            labelText: 'Search',
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
