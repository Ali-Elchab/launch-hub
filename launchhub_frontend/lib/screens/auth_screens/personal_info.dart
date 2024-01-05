import 'package:flutter/material.dart';
import 'package:launchhub_frontend/models/industry.dart';
import 'package:launchhub_frontend/models/niche.dart';
import 'package:launchhub_frontend/screens/auth_screens/contact_info.dart';
import 'package:launchhub_frontend/widgets/auth_widgets/bottom_text.dart';
import 'package:launchhub_frontend/widgets/auth_widgets/date_picker.dart';
import 'package:launchhub_frontend/widgets/auth_widgets/industry_drop_down.dart';
import 'package:launchhub_frontend/widgets/auth_widgets/niche_drop_down.dart';
import 'package:launchhub_frontend/widgets/auth_widgets/profile_pic_input.dart';
import 'package:launchhub_frontend/widgets/auth_widgets/custom_appbar.dart';
import 'package:launchhub_frontend/widgets/input_field.dart';
import 'package:launchhub_frontend/widgets/small_button.dart';
import 'package:intl/intl.dart';
import 'package:launchhub_frontend/data/mockData.dart';
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
  Niche? _niche;
  XFile? _image;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    // _selectedIndustry = _industries.isNotEmpty ? _industries.first : null;
  }

  @override
  void dispose() {
    _controller.dispose();
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
        _controller.text =
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

  void onNext() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ContactInfo(
          selectedImage: _image,
        ),
      ),
    );
  }

  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field cannot be empty';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const CustomAppBar(title: 'Job Seeker Profile'),
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          width: 300,
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      'Personal Information',
                      textAlign: TextAlign.left,
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(fontWeight: FontWeight.w700, fontSize: 22),
                    ),
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
                        InputField(label: 'First Name', validator: validator),
                        DatePickerField(
                            controller: _controller,
                            onTap: () => _selectDate(context),
                            validator: validator,
                            text: 'Date of Birth'),
                        const SizedBox(height: 16),
                        InputField(label: 'Phone Number', validator: validator),
                        InputField(
                            label: 'Professional Biography',
                            isDescription: true,
                            validator: validator),
                        IndustryDropDown(
                          list: industries,
                          value: _selectedIndustry,
                          validator: (value) {
                            if (value == null) {
                              return 'This field cannot be empty';
                            }
                            return null;
                          },
                          onChanged: (Industry? newValue) {
                            setState(() {
                              _selectedIndustry = newValue;
                            });
                          },
                        ),
                        const SizedBox(height: 16),
                        NicheDropDown(
                          list: niches,
                          value: _niche,
                          text: 'Specialization',
                          validator: (value) {
                            if (value == null) {
                              return 'This field cannot be empty';
                            }
                            return null;
                          },
                          onChanged: (Niche? newValue) {
                            setState(() {
                              _niche = newValue;
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
                    onNext();
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
    );
  }
}
