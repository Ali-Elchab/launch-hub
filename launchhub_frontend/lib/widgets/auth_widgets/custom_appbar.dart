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
            ? const EdgeInsets.symmetric(horizontal: 39)
            : EdgeInsets.zero,
        child: Transform.translate(
          offset: Offset(showBackButton ? -16 : 0, 0),
          child: Text(
            title,
            style: TextStyle(
              color: textColor ?? Colors.black,
              fontSize: showBackButton ? 30 : 42,
              fontFamily: 'inter',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: showBackButton
          ? Padding(
              padding: const EdgeInsets.only(left: 6),
              child: IconButton(
                icon: Icon(
                  Icons.arrow_circle_left_outlined,
                  color: textColor ?? Colors.black,
                  size: 36,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            )
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
