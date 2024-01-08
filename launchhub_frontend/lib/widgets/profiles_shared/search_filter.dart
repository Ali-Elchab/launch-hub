import 'package:flutter/material.dart';

class SearchFilter extends StatelessWidget {
  const SearchFilter(
      {super.key, required this.onPressedFilter, this.margin = 25});

  final Function onPressedFilter;
  final double margin;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: margin),
      child: Row(
        children: [
          Expanded(
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
            ),
          ),
          const SizedBox(width: 5),
          IconButton(
            icon: Icon(Icons.filter_alt_outlined,
                color: Theme.of(context).colorScheme.primary),
            onPressed: onPressedFilter(),
          ),
        ],
      ),
    );
  }
}
