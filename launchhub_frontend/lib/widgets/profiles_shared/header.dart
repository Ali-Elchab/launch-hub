import 'package:flutter/material.dart';
import 'package:launchhub_frontend/widgets/auth_widgets/custom_appbar.dart';

class Header extends StatelessWidget {
  final String title;
  final Color? textColor;
  final bool showBackButton;

  const Header({
    super.key,
    required this.title,
    this.textColor = Colors.white,
    this.showBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(37),
          bottomRight: Radius.circular(37),
        ),
        image: DecorationImage(
          image: textColor == Colors.white
              ? const AssetImage('assets/backgrounds/header.png')
              : const AssetImage(''),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Use minimal space for the Column
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomAppBar(
            title: title,
            textColor: textColor,
            showBackButton: showBackButton ? true : false,
          ),
          Expanded(
            child: SizedBox(
              width: 280,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: const ClampingScrollPhysics(),
                child: Text(
                  textAlign: TextAlign.left,
                  'Your Premier App for Turning Visions into Reality ',
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: textColor,
                        fontSize: showBackButton ? 14 : 22,
                      ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
