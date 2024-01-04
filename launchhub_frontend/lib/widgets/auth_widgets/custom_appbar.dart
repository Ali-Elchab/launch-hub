import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color? textColor;
  final bool showBackButton;

  const CustomAppBar({
    super.key,
    required this.title,
    this.textColor,
    this.showBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Padding(
        padding: !showBackButton
            ? const EdgeInsets.symmetric(horizontal: 48)
            : EdgeInsets.zero,
        child: Text(
          title,
          style: TextStyle(
            color: textColor ??
                Colors.black, // Fallback color if textColor is null
            fontSize: showBackButton ? 30 : 42,
            fontFamily: 'inter',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: showBackButton // Check if the back button should be shown
          ? Padding(
              padding: const EdgeInsets.only(left: 15, right: 2),
              child: IconButton(
                icon: Icon(
                  Icons.arrow_circle_left_outlined,
                  color: textColor ?? Colors.black, // Fallback color
                  size: 36,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            )
          : null, // Hide the back button by setting leading to null
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
