import 'package:flutter/material.dart';
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
        builder: (context) => CompanyInfo2(
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
      appBar: const CustomAppBar(title: 'Startup Profile'),
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          width: 300,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      'Company Information',
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
                        validator: validator,
                      ),
                      const SizedBox(height: 16),
                      const InputField(label: 'Registration Number'),
                      const InputField(
                          label: 'Company Description', isDescription: true),
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
                      const SizedBox(height: 16),
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
                  )),
                ),
                SmallButton('Next', () {
                  if (_formKey.currentState!.validate()) {
                    onNext();
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
    );
  }
}
