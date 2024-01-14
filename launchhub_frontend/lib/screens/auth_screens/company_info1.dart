import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:launchhub_frontend/helpers/navigator.dart';
import 'package:launchhub_frontend/models/industry.dart';
import 'package:launchhub_frontend/models/niche.dart';
import 'package:launchhub_frontend/providers/startup_register_provider.dart';
import 'package:launchhub_frontend/screens/auth_screens/company_info2.dart';
import 'package:launchhub_frontend/widgets/auth_widgets/bottom_text.dart';
import 'package:launchhub_frontend/widgets/auth_widgets/profile_pic_input.dart';
import 'package:launchhub_frontend/widgets/custom_appbar.dart';
import 'package:launchhub_frontend/widgets/generic_drop_down.dart';
import 'package:launchhub_frontend/widgets/input_field.dart';
import 'package:launchhub_frontend/widgets/small_button.dart';

class CompanyInfo1 extends ConsumerStatefulWidget {
  const CompanyInfo1({super.key});

  @override
  ConsumerState<CompanyInfo1> createState() => _CompanyInfo1State();
}

class _CompanyInfo1State extends ConsumerState<CompanyInfo1> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    ref.read(startupRegisterProvider.notifier).getIndustries();
  }

  Future getNiches() async {
    await ref.read(startupRegisterProvider.notifier).getNiches();
  }

  // @override
  // void dispose() {
  //   _controller.dispose();
  //   super.dispose();
  // }

  String? validator(value) {
    if (value == null || value.isEmpty) {
      return 'This field cannot be empty';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final startupregisterprovider = ref.watch(startupRegisterProvider);
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
                        await ref
                            .read(startupRegisterProvider.notifier)
                            .pickImage();
                      },
                      imageFile: startupregisterprovider.selectedImage,
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
                            controller: startupregisterprovider.date,
                            onTap: () => ref
                                .read(startupRegisterProvider.notifier)
                                .selectDate(context),
                            validator: validator),
                        const InputField(label: 'Registration Number'),
                        const InputField(
                            label: 'Company Description', isDescription: true),
                        GenericDropdown<Industry>(
                          label: 'Industry',
                          options: startupregisterprovider.industries,
                          selectedOption:
                              startupregisterprovider.selectedIndustry,
                          optionLabel: (industry) => industry!.name,
                          validator: validator,
                          onChanged: (newValue) async {
                            ref
                                .read(startupRegisterProvider.notifier)
                                .setSelectedIndustry(newValue!);
                            await getNiches();
                          },
                        ),
                        GenericDropdown<Niche>(
                          label: 'Niche',
                          options: startupregisterprovider.niches,
                          validator: validator,
                          selectedOption: startupregisterprovider.selectedNiche,
                          optionLabel: (niche) => niche!.name,
                          onChanged: (newValue) {
                            ref
                                .read(startupRegisterProvider.notifier)
                                .setSelectedNiche(newValue!);
                          },
                        ),
                      ],
                    )),
                  ),
                  SmallButton('Next', () {
                    if (_formKey.currentState!.validate() &&
                        startupregisterprovider.selectedNiche != null &&
                        startupregisterprovider.selectedIndustry != null) {
                      navigator(
                        context,
                        const CompanyInfo2(),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            backgroundColor: Color.fromARGB(255, 156, 10, 0),
                            content: Text(
                              'Please fill Company Name, Founding Date, Industry and Niche fields',
                            )),
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
