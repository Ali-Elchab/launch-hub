import 'package:flutter/material.dart';
import 'package:launchhub_frontend/widgets/custom_appbar.dart';

class Header extends StatelessWidget {
  final String title;
  final Color? textColor;
  final bool showBackButton;
  final String text;
  const Header({
    super.key,
    required this.title,
    required this.text,
    this.textColor = Colors.white,
    this.showBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20),
      height: 200,
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
              width: 300,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: const ClampingScrollPhysics(),
                child: Text(
                  textAlign: TextAlign.left,
                  text,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: textColor,
                        fontSize: showBackButton ? 14 : 20,
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
