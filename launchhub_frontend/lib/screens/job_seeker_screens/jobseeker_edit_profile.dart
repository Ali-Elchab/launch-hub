// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:launchhub_frontend/config/base_dio.dart';
import 'package:launchhub_frontend/data/api_constants.dart';
import 'package:launchhub_frontend/models/industry.dart';
import 'package:launchhub_frontend/models/niche.dart';
import 'package:launchhub_frontend/providers/startup_profile_provider.dart';
import 'package:launchhub_frontend/widgets/auth_widgets/profile_pic_input.dart';
import 'package:launchhub_frontend/widgets/auth_widgets/social_media_inputs.dart';
import 'package:launchhub_frontend/widgets/input_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JobSeekerEditProfile extends ConsumerStatefulWidget {
  const JobSeekerEditProfile({super.key});

  @override
  ConsumerState<JobSeekerEditProfile> createState() =>
      _JobSeekerEditProfileState();
}

class _JobSeekerEditProfileState extends ConsumerState<JobSeekerEditProfile> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final companyDescriptionController = TextEditingController();
  final registrationNumberController = TextEditingController();
  final companyNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final websiteController = TextEditingController();
  final linkedinController = TextEditingController();
  final facebookController = TextEditingController();
  final instagramController = TextEditingController();
  final githubController = TextEditingController();
  final locationController = TextEditingController();
  final foundingDateController = TextEditingController();
  String base64Image = '';
  Uint8List? logo;

  Industry? industry;
  Niche? niche;
  List selectedSocialMedia = [];
  List founders = [];
  List ceos = [];
  List keyexecutives = [];

  bool edit = false;

  @override
  void initState() {
    super.initState();
    final profileProvider = ref.read(startupProfileProvider);
    loadData();
    companyDescriptionController.text =
        profileProvider.startup.companyDescription;
    registrationNumberController.text =
        profileProvider.startup.registrationNumber!;
    companyNameController.text = profileProvider.startup.companyName;
    phoneController.text = profileProvider.startup.companyName;
    emailController.text = profileProvider.startup.companyEmail;
    selectedSocialMedia = profileProvider.startup.socialMediaLinks;
    websiteController.text = profileProvider.startup.companyWebsiteUrl!;
    founders = profileProvider.startup.founders!;
    ceos = profileProvider.startup.ceos!;
    keyexecutives = profileProvider.startup.keyExcecutives!;
    locationController.text = profileProvider.startup.companyAddress;
    foundingDateController.text = profileProvider.startup.foundingDate;
    // logo = base64Decode(profileProvider.startup.copmanyLogo!);

    for (var i = 0; i < selectedSocialMedia.length; i++) {
      if (selectedSocialMedia[i]['platform'] == 'LinkedIn') {
        linkedinController.text = selectedSocialMedia[i]['link'];
      } else if (selectedSocialMedia[i]['platform'] == 'Facebook') {
        facebookController.text = selectedSocialMedia[i]['link'];
      } else if (selectedSocialMedia[i]['platform'] == 'Instagram') {
        instagramController.text = selectedSocialMedia[i]['link'];
      } else if (selectedSocialMedia[i]['platform'] == 'Github') {
        githubController.text = selectedSocialMedia[i]['link'];
      }
    }
  }

  void loadData() async {
    final profileProvider = ref.read(startupProfileProvider);
    final industry = await myDio
        .get('${ApiRoute.getIndustries}/${profileProvider.startup.industryId}');
    final specialization = await myDio.get(
        '${ApiRoute.getSpecializations}/${profileProvider.startup.specializationId}');
    if (mounted) {
      setState(() {
        this.industry = Industry.fromJson(industry.data['industry']);
        niche = Niche.fromJson(specialization.data['specialization']);
      });
    }
  }

  Future pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? selectedImage =
        await picker.pickImage(source: ImageSource.gallery);
    if (selectedImage != null) {
      var compressedBytes = await FlutterImageCompress.compressWithFile(
        selectedImage.path,
        minWidth: 200,
        minHeight: 200,
        quality: 75,
      );
      if (compressedBytes != null) {
        base64Image = base64Encode(compressedBytes);
      }
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
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        Column(
          children: [
            Container(
              height: 200,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/backgrounds/header.png'),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(37),
                    bottomRight: Radius.circular(37)),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 0, 0, 0),
                    offset: Offset(0, -0.01),
                    blurRadius: 6.00,
                    spreadRadius: 0.00,
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 45,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Text('Profile',
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                color: Colors.white,
                              )),
                ),
                Align(
                  alignment: Alignment.topLeft + const Alignment(0.1, 0),
                  child: GestureDetector(
                    onTap: () async {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Log Out'),
                              content: const Text(
                                  'Are you sure you want to log out?'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Cancel')),
                                TextButton(
                                  onPressed: () async {
                                    final prefs =
                                        await SharedPreferences.getInstance();
                                    final token = prefs.getString('token');
                                    final logout =
                                        await myDio.post(ApiRoute.logout,
                                            options: Options(
                                              headers: {
                                                'Authorization':
                                                    'Bearer $token',
                                              },
                                            ));

                                    if (logout.statusCode == 200) {
                                      Navigator.pushNamedAndRemoveUntil(
                                          context, '/SignIn', (route) => false);
                                    }
                                  },
                                  child: Text(
                                    'Log Out',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall!
                                        .copyWith(
                                            color:
                                                Theme.of(context).primaryColor),
                                  ),
                                ),
                              ],
                            );
                          });
                    },
                    child: Text('Log Out',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: Colors.white,
                            )),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 100,
          bottom: 0,
          child: Container(
            padding:
                const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 10),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(37),
                topRight: Radius.circular(37),
              ),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  offset: Offset(0.1, 1),
                  blurRadius: 0.60,
                  spreadRadius: 0.00,
                ),
              ],
            ),
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: ProfileImagePicker(
                      onImagePicked: () async {
                        pickImage();
                      },
                      decodedImage: logo,
                      text: 'Upload Logo'),
                ),
                const SizedBox(
                  width: 20,
                ),
                const Divider(
                  color: Color.fromARGB(94, 158, 158, 158),
                  height: 20,
                  thickness: 1,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Company Information',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(
                                      color: const Color.fromARGB(
                                          200, 158, 158, 158),
                                      fontWeight: FontWeight.normal,
                                      fontSize: 20)),
                          const SizedBox(
                            height: 15,
                          ),
                          InputField(
                            label: 'Company Name',
                            readOnly: !edit,
                            validator: validator,
                            controller: companyNameController,
                          ),
                          InputField(
                              label: 'Founding Date',
                              readOnly: true,
                              icon: const Icon(Icons.calendar_today),
                              controller: foundingDateController,
                              validator: validator),
                          InputField(
                            label: 'Registration Number',
                            readOnly: !edit,
                            validator: validator,
                            controller: registrationNumberController,
                          ),
                          InputField(
                            label: 'Company Description',
                            isDescription: true,
                            validator: validator,
                            readOnly: !edit,
                            controller: companyDescriptionController,
                          ),
                          InputField(
                              label: 'Industry',
                              validator: validator,
                              readOnly: true,
                              controller: TextEditingController(
                                text: industry == null ? '' : industry!.name,
                              )),
                          InputField(
                              label: 'Niche',
                              validator: validator,
                              readOnly: true,
                              controller: TextEditingController(
                                text: niche == null ? '' : niche!.name,
                              )),
                          const Divider(
                            color: Color.fromARGB(94, 158, 158, 158),
                            height: 20,
                            thickness: 1,
                          ),
                          Text('Contact Info',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(
                                      color: const Color.fromARGB(
                                          200, 158, 158, 158),
                                      fontWeight: FontWeight.normal,
                                      fontSize: 20)),
                          const SizedBox(
                            height: 15,
                          ),
                          InputField(
                            label: 'Business Address',
                            readOnly: !edit,
                            controller: locationController,
                          ),
                          InputField(
                            label: 'Phone Number',
                            validator: validator,
                            readOnly: !edit,
                            controller: phoneController,
                          ),
                          InputField(
                            label: 'Email Address',
                            readOnly: !edit,
                            validator: validator,
                            controller: emailController,
                          ),
                          InputField(
                            label: 'Website URL',
                            readOnly: !edit,
                            controller: websiteController,
                          ),
                          SocialMediaLinksDropdown(
                            linkedinController: linkedinController,
                            facebookController: facebookController,
                            instagramController: instagramController,
                            githubController: githubController,
                          ),
                          const Divider(
                            color: Color.fromARGB(94, 158, 158, 158),
                            height: 20,
                            thickness: 1,
                          ),
                          Text('Founders & Key Team Members',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(
                                      color: const Color.fromARGB(
                                          200, 158, 158, 158),
                                      fontWeight: FontWeight.normal,
                                      fontSize: 20)),
                          const SizedBox(
                            height: 15,
                          ),
                          InputField(
                            label: 'Founders Names',
                            validator: validator,
                            readOnly: true,
                            controller: TextEditingController(
                                text: founders
                                    .map((founder) => founder)
                                    .join(', ')),
                          ),
                          InputField(
                            label: 'CEOs Names',
                            readOnly: true,
                            controller: TextEditingController(
                                text: ceos.map((ceo) => ceo).join(', ')),
                          ),
                          InputField(
                            label: 'Key Executives',
                            validator: validator,
                            readOnly: true,
                            controller: TextEditingController(
                                text: keyexecutives
                                    .map((keyexecutive) => keyexecutive)
                                    .join(', ')),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () async {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text('Delete Account'),
                                        content: const Text(
                                            'Are you sure you want to delete your account?'),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text('Cancel')),
                                          TextButton(
                                            onPressed: () async {
                                              final prefs =
                                                  await SharedPreferences
                                                      .getInstance();
                                              final token =
                                                  prefs.getString('token');
                                              final delete = await myDio.delete(
                                                ApiRoute.deleteStartupProfile,
                                                options: Options(
                                                  headers: {
                                                    'Authorization':
                                                        'Bearer $token',
                                                  },
                                                ),
                                              );
                                              if (delete.statusCode == 200) {
                                                Navigator
                                                    .pushNamedAndRemoveUntil(
                                                        context,
                                                        '/SignIn',
                                                        (route) => false);
                                              }
                                            },
                                            child: Text(
                                              'Delete Account',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelSmall!
                                                  .copyWith(
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                            ),
                                          ),
                                        ],
                                      );
                                    });
                              },
                              child: Text(
                                'Delete Account',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall!
                                    .copyWith(
                                        color: Theme.of(context).primaryColor),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 120,
          right: 65,
          child: Align(
            alignment: Alignment.topRight + const Alignment(-0.1, 0),
            child: GestureDetector(
              onTap: () async {
                if (edit) {
                  if (_formKey.currentState!.validate()) {
                    selectedSocialMedia = [];
                    if (linkedinController.text.isNotEmpty) {
                      selectedSocialMedia.add({
                        'platform': 'LinkedIn',
                        'link': linkedinController.text,
                      });
                    }
                    if (facebookController.text.isNotEmpty) {
                      selectedSocialMedia.add({
                        'platform': 'Facebook',
                        'link': facebookController.text,
                      });
                    }
                    if (instagramController.text.isNotEmpty) {
                      selectedSocialMedia.add({
                        'platform': 'Instagram',
                        'link': instagramController.text,
                      });
                    }
                    if (githubController.text.isNotEmpty) {
                      selectedSocialMedia.add({
                        'platform': 'Github',
                        'url': githubController.text,
                      });
                    }
                    final data = {
                      'user_id': ref.read(startupProfileProvider).user.id,
                      'id': ref.read(startupProfileProvider).startup.id,
                      'company_name': companyNameController.text,
                      'company_description': companyDescriptionController.text,
                      'registration_number': registrationNumberController.text,
                      'founding_date': foundingDateController.text,
                      'profilePic': base64Image,
                      'company_address': locationController.text,
                      'company_phone': phoneController.text,
                      'company_email': emailController.text,
                      'website_url': websiteController.text,
                      'socialMediaLinks': selectedSocialMedia,
                      'social_media_links': selectedSocialMedia,
                      'founders': founders,
                      'ceos': ceos,
                      'key_executives': keyexecutives,
                      'logo_url': base64Image,
                      "industry_id": industry!.id,
                      "specialization_id": niche!.id,
                    };
                    final update = await ref
                        .read(startupProfileProvider)
                        .updateStartupProfile(data);
                    if (update == 'success') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Profile Updated Successfully'),
                        ),
                      );
                    }
                  }
                }
                setState(() {
                  edit = !edit;
                });
              },
              child: Text(edit ? 'Save' : 'Edit',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).primaryColor,
                      )),
            ),
          ),
        ),
      ],
    );
  }
}
