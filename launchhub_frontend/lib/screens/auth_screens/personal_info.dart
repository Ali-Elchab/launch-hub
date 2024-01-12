import 'package:flutter/material.dart';
import 'package:launchhub_frontend/helpers/navigator.dart';
import 'package:launchhub_frontend/models/industry.dart';
import 'package:launchhub_frontend/models/niche.dart';
import 'package:launchhub_frontend/screens/auth_screens/contact_info.dart';
import 'package:launchhub_frontend/widgets/auth_widgets/bottom_text.dart';
import 'package:launchhub_frontend/widgets/auth_widgets/profile_pic_input.dart';
import 'package:launchhub_frontend/widgets/custom_appbar.dart';
import 'package:launchhub_frontend/widgets/generic_drop_down.dart';
import 'package:launchhub_frontend/widgets/input_field.dart';
import 'package:launchhub_frontend/widgets/small_button.dart';
import 'package:intl/intl.dart';
import 'package:launchhub_frontend/data/mock_data.dart';
import 'package:image_picker/image_picker.dart';

class PersonalInfo extends StatefulWidget {
  const PersonalInfo({super.key});

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DateTime? selectedDate;
  Industry? _selectedIndustry;
  Niche? _selectedNiche;
  XFile? _image;
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final bioController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();

  @override
  void dispose() {
    _dobController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    bioController.dispose();
    selectedDate = null;
    _selectedIndustry = null;
    _selectedNiche = null;
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _dobController.text =
            DateFormat('yyyy-MM-dd').format(picked); // Format date as required
      });
    }
  }

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
                      'Personal Information',
                      textAlign: TextAlign.left,
                      style: textTheme.titleLarge,
                    ),
                  ),
                  const SizedBox(height: 35),
                  ProfileImagePicker(
                      onImagePicked: () async {
                        await _pickImage();
                      },
                      imageFile: _image,
                      text: 'Upload Profile Picture'),
                  const SizedBox(height: 32),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Column(
                        children: [
                          InputField(
                              label: 'First Name',
                              validator: validator,
                              controller: firstNameController),
                          InputField(
                              label: 'Last Name',
                              validator: validator,
                              controller: lastNameController),
                          InputField(
                            label: 'Date of Birth',
                            readOnly: true,
                            icon: const Icon(Icons.calendar_today),
                            controller: _dobController,
                            onTap: () => _selectDate(context),
                            validator: validator,
                          ),
                          InputField(
                              label: 'Phone Number',
                              validator: validator,
                              controller: phoneController),
                          InputField(
                              label: 'Professional Biography',
                              isDescription: true,
                              controller: bioController,
                              validator: validator),
                          GenericDropdown<Industry>(
                            label: 'Select Industry',
                            options: industries,
                            selectedOption: _selectedIndustry,
                            optionLabel: (industry) => industry!.name,
                            onChanged: (newValue) {
                              setState(() {
                                _selectedIndustry = newValue;
                              });
                            },
                          ),
                          GenericDropdown<Niche>(
                            label: 'Select Niche',
                            options: niches,
                            selectedOption: _selectedNiche,
                            optionLabel: (niche) => niche!.name,
                            onChanged: (newValue) {
                              setState(() {
                                _selectedNiche = newValue;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  SmallButton('Next', () {
                    if (_formKey.currentState!.validate()) {
                      navigator(
                        context,
                        ContactInfo(
                          selectedImage: _image,
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
