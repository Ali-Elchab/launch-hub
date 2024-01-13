import 'dart:io';

import 'package:flutter/material.dart';
import 'package:launchhub_frontend/helpers/navigator.dart';
import 'package:launchhub_frontend/screens/auth_screens/education_info.dart';
import 'package:launchhub_frontend/widgets/auth_widgets/bottom_text.dart';
import 'package:launchhub_frontend/widgets/auth_widgets/profile_pic_input.dart';
import 'package:launchhub_frontend/widgets/auth_widgets/social_media_inputs.dart';
import 'package:launchhub_frontend/widgets/custom_appbar.dart';
import 'package:launchhub_frontend/widgets/input_field.dart';
import 'package:launchhub_frontend/widgets/location_picker.dart';
import 'package:launchhub_frontend/widgets/small_button.dart';
import 'package:image_picker/image_picker.dart';

class ContactInfo extends StatefulWidget {
  final XFile? selectedImage;

  const ContactInfo({super.key, required this.selectedImage});

  @override
  State<ContactInfo> createState() => _ContactInfoState();
}

class _ContactInfoState extends State<ContactInfo> {
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? address;
  String? country;
  String? state;
  XFile? _image;
  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? selectedImage =
        await picker.pickImage(source: ImageSource.gallery);

    if (selectedImage != null) {
      setState(() {
        _image = selectedImage;
      });
    }
  }

  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field cannot be empty';
    }
    return null;
  }

  setCountry(String? value) {
    setState(() {
      country = value;
    });
  }

  setStateForState(String? value) {
    setState(() {
      state = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: const CustomAppBar(title: 'Job Seeker Profile'),
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.only(top: 85),
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/backgrounds/auth_bg.png'),
              fit: BoxFit.cover),
        ),
        child: Center(
          child: SizedBox(
            width: 300,
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Contact Information',
                      textAlign: TextAlign.left,
                      style: textTheme.titleLarge,
                    ),
                  ),
                  const SizedBox(height: 35),
                  if (widget.selectedImage != null)
                    ClipOval(
                      child: Image.file(
                        File(widget.selectedImage!.path),
                        width: 120, // Diameter of the circle
                        height: 120, // Diameter of the circle
                        fit: BoxFit
                            .cover, // This ensures the image covers the circle crop
                      ),
                    ),
                  if (widget.selectedImage == null)
                    ProfileImagePicker(
                        onImagePicked: () async {
                          await _pickImage();
                        },
                        imageFile: _image,
                        text: 'Upload Profile Picture'),
                  const SizedBox(height: 32),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          LocationPicker(
                            onCountryChanged: setCountry,
                            onStateChanged: setStateForState,
                            country: country,
                            state: state,
                          ),
                          InputField(
                              label: 'Phone Number', validator: validator),
                          const SocialMediaLinksDropdown(),
                        ],
                      ),
                    ),
                  ),
                  SmallButton('Next', () {
                    address = '$state, $country';

                    if (_formKey.currentState!.validate() && address != null) {
                      navigator(context, const EducationInfo());
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please fill in all the fields'),
                        ),
                      );
                    }
                  }),
                  const SizedBox(height: 15),
                  const BottomText(
                      text:
                          'Your provided details will be utilized to shape a personalized resume, presenting your unique skills and experiences to startups seeking candidates like you.'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
