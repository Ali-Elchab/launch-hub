import 'package:flutter/material.dart';
import 'package:launchhub_frontend/helpers/navigator.dart';
import 'package:launchhub_frontend/models/industry.dart';
import 'package:launchhub_frontend/models/niche.dart';
import 'package:launchhub_frontend/screens/auth_screens/company_info2.dart';
import 'package:launchhub_frontend/widgets/auth_widgets/bottom_text.dart';
import 'package:launchhub_frontend/widgets/auth_widgets/profile_pic_input.dart';
import 'package:launchhub_frontend/widgets/custom_appbar.dart';
import 'package:launchhub_frontend/widgets/generic_drop_down.dart';
import 'package:launchhub_frontend/widgets/input_field.dart';
import 'package:launchhub_frontend/widgets/small_button.dart';
import 'package:intl/intl.dart';
import 'package:launchhub_frontend/data/mock_data.dart';
import 'package:image_picker/image_picker.dart';

class CompanyInfo1 extends StatefulWidget {
  const CompanyInfo1({super.key});

  @override
  State<CompanyInfo1> createState() => _CompanyInfo1State();
}

class _CompanyInfo1State extends State<CompanyInfo1> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DateTime? selectedDate;
  Industry? _selectedIndustry;
  Niche? _selectedNiche;
  XFile? _image;
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
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

  String? validator(value) {
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
      appBar: const CustomAppBar(title: 'Startup Profile'),
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
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Company Information',
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
                      text: 'Upload Logo'),
                  const SizedBox(height: 22),
                  Expanded(
                    child: SingleChildScrollView(
                        child: Column(
                      children: [
                        const SizedBox(height: 16),
                        InputField(label: 'Company Name', validator: validator),
                        InputField(
                            label: 'Founding Date',
                            readOnly: true,
                            icon: const Icon(Icons.calendar_today),
                            controller: _controller,
                            onTap: () => _selectDate(context),
                            validator: validator),
                        const InputField(label: 'Registration Number'),
                        const InputField(
                            label: 'Company Description', isDescription: true),
                        GenericDropdown<Industry>(
                          label: 'Select Industry',
                          options: industries,
                          selectedOption: _selectedIndustry,
                          optionLabel: (industry) => industry!.name,
                          validator: validator,
                          onChanged: (newValue) {
                            setState(() {
                              _selectedIndustry = newValue;
                            });
                          },
                        ),
                        GenericDropdown<Niche>(
                          label: 'Select Niche',
                          options: niches,
                          validator: validator,
                          selectedOption: _selectedNiche,
                          optionLabel: (niche) => niche!.name,
                          onChanged: (newValue) {
                            setState(() {
                              _selectedNiche = newValue;
                            });
                          },
                        ),
                      ],
                    )),
                  ),
                  SmallButton('Next', () {
                    if (_formKey.currentState!.validate()) {
                      navigator(
                        context,
                        CompanyInfo2(
                          selectedImage: _image,
                        ),
                      );
                    }
                  }),
                  const SizedBox(height: 15),
                  const BottomText(
                    text:
                        'This information will be showcased to job seekers, helping them make informed decisions about opportunities with your company.',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
