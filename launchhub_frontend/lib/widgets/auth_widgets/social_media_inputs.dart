import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SocialMediaLinksDropdown extends StatefulWidget {
  const SocialMediaLinksDropdown(
      {super.key,
      required this.linkedinController,
      required this.facebookController,
      required this.instagramController,
      required this.githubController});

  final TextEditingController linkedinController;
  final TextEditingController facebookController;
  final TextEditingController instagramController;
  final TextEditingController githubController;

  @override
  // ignore: library_private_types_in_public_api
  _SocialMediaLinksDropdownState createState() =>
      _SocialMediaLinksDropdownState();
}

class _SocialMediaLinksDropdownState extends State<SocialMediaLinksDropdown> {
  @override
  void dispose() {
    widget.linkedinController.dispose();
    widget.facebookController.dispose();
    widget.instagramController.dispose();
    widget.githubController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      shape: const Border(top: BorderSide.none),
      collapsedBackgroundColor: const Color(0xFFF5F5F5),
      collapsedTextColor: const Color.fromARGB(255, 48, 48, 48),
      collapsedShape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      tilePadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      title: const Text('Social Media Links'),
      collapsedIconColor: const Color.fromARGB(255, 48, 48, 48),
      leading: const Icon(Icons.link),
      children: <Widget>[
        _buildSocialMediaTextField(
          controller: widget.linkedinController,
          context: context,
          hintText: 'LinkedIn',
          icon: FontAwesomeIcons.linkedinIn,
        ),
        _buildSocialMediaTextField(
          controller: widget.facebookController,
          context: context,
          hintText: 'Facebook',
          icon: FontAwesomeIcons.facebook,
        ),
        _buildSocialMediaTextField(
          controller: widget.instagramController,
          context: context,
          hintText: 'Instagram',
          icon: FontAwesomeIcons.instagram,
        ),
        _buildSocialMediaTextField(
          controller: widget.githubController,
          context: context,
          hintText: 'GitHub',
          icon: FontAwesomeIcons.github,
        ),
      ],
    );
  }

  Widget _buildSocialMediaTextField({
    required TextEditingController controller,
    required BuildContext context,
    required String hintText,
    required IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          filled: true,
          fillColor: const Color(0xFFF5F5F5),
          hintText: hintText,
          hintStyle: Theme.of(context).textTheme.labelMedium!,
          icon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
        ),
      ),
    );
  }
}
