import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title,
          style: const TextStyle(
              color: Colors.black,
              fontSize: 30,
              fontFamily: 'inter',
              fontWeight: FontWeight.bold)),
      backgroundColor: Colors.transparent, // Transparent AppBar
      elevation: 0, // Remove AppBar shadow
      leading: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: IconButton(
          icon: const Icon(
            Icons.arrow_circle_left_outlined,
            color: Colors.black,
            size: 36,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
