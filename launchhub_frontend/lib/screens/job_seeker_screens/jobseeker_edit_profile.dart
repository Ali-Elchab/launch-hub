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
import 'package:launchhub_frontend/models/certification.dart';
import 'package:launchhub_frontend/models/education.dart';
import 'package:launchhub_frontend/models/experience.dart';
import 'package:launchhub_frontend/models/industry.dart';
import 'package:launchhub_frontend/models/niche.dart';
import 'package:launchhub_frontend/models/skill.dart';
import 'package:launchhub_frontend/providers/hire_talent_provider.dart';
import 'package:launchhub_frontend/providers/job_seeker_profile_provider.dart';
import 'package:launchhub_frontend/widgets/auth_widgets/add_experience.dart';
import 'package:launchhub_frontend/widgets/auth_widgets/profile_pic_input.dart';
import 'package:launchhub_frontend/widgets/auth_widgets/social_media_inputs.dart';
import 'package:launchhub_frontend/widgets/input_field.dart';
import 'package:launchhub_frontend/widgets/startup/educational_background.dart';
import 'package:launchhub_frontend/widgets/startup/experience.dart';
import 'package:launchhub_frontend/widgets/startup/skills_and_hobbies.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:launchhub_frontend/helpers/show_modal_sheet.dart';
import 'package:launchhub_frontend/widgets/auth_widgets/add_education.dart';

class JobSeekerEditProfile extends ConsumerStatefulWidget {
  const JobSeekerEditProfile({super.key});

  @override
  ConsumerState<JobSeekerEditProfile> createState() =>
      _JobSeekerEditProfileState();
}

class _JobSeekerEditProfileState extends ConsumerState<JobSeekerEditProfile> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final bioController = TextEditingController();
  final dobController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final linkedinController = TextEditingController();
  final facebookController = TextEditingController();
  final instagramController = TextEditingController();
  final githubController = TextEditingController();
  final locationController = TextEditingController();
  String base64Image = '';
  Uint8List? profilePic;
  Uint8List? resume;

  Industry? industry;
  Niche? niche;
  List selectedSocialMedia = [];
  List<Education> education = [];
  List<Experience> experience = [];
  List<Certification> certification = [];
  List selectedSkills = [];
  List selectedHobbies = [];

  bool edit = false;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    final hiretalentProvider = ref.read(hireTalentProvider.notifier);
    final profileProvider = ref.read(jobSeekerProfileProvider);
    await hiretalentProvider.getJobSeekerProfile(profileProvider.jobSeeker.id);
    final industry = await myDio.get(
        '${ApiRoute.getIndustries}/${profileProvider.jobSeeker.industryId}');
    final specialization = await myDio.get(
        '${ApiRoute.getSpecializations}/${profileProvider.jobSeeker.specializationId}');
    if (mounted) {
      setState(() {
        this.industry = Industry.fromJson(industry.data['industry']);
        niche = Niche.fromJson(specialization.data['specialization']);
      });
    }
    bioController.text = hiretalentProvider.jobSeeker!.bio;
    firstNameController.text = hiretalentProvider.jobSeeker!.firstName;
    lastNameController.text = hiretalentProvider.jobSeeker!.lastName;
    dobController.text = hiretalentProvider.jobSeeker!.dob;
    phoneController.text = hiretalentProvider.jobSeeker!.phone;
    emailController.text = profileProvider.user.email;
    selectedSocialMedia = hiretalentProvider.socialMediaLinks;
    locationController.text = hiretalentProvider.jobSeeker!.address;
    education = hiretalentProvider.educations;
    experience = hiretalentProvider.experiences;
    certification = hiretalentProvider.certifications;
    selectedSkills = hiretalentProvider.skills;
    selectedHobbies = hiretalentProvider.hobbies;
    profilePic = profileProvider.jobSeeker.profilePic != null
        ? base64Decode(profileProvider.jobSeeker.profilePic!)
        : null;
    resume = profileProvider.jobSeeker.resume != null
        ? base64Decode(profileProvider.jobSeeker.resume!)
        : null;

    for (var i = 0; i < selectedSocialMedia.length; i++) {
      if (selectedSocialMedia[i].platform == 'linkedIn') {
        linkedinController.text = selectedSocialMedia[i].link;
      } else if (selectedSocialMedia[i].platform == 'Facebook') {
        facebookController.text = selectedSocialMedia[i].link;
      } else if (selectedSocialMedia[i].platform == 'instagram') {
        instagramController.text = selectedSocialMedia[i].link;
      } else if (selectedSocialMedia[i].platform == 'github') {
        githubController.text = selectedSocialMedia[i].link;
      }
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
                      decodedImage: profilePic,
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
                          Text('Personal Information',
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
                              label: 'First Name',
                              validator: validator,
                              readOnly: !edit,
                              controller: firstNameController),
                          InputField(
                              label: 'Last Name',
                              validator: validator,
                              readOnly: !edit,
                              controller: lastNameController),
                          InputField(
                            label: 'Date of Birth',
                            readOnly: !edit,
                            icon: const Icon(Icons.calendar_today),
                            controller: dobController,
                            onTap: () => {},
                            validator: validator,
                          ),
                          InputField(
                              label: 'Professional Biography',
                              isDescription: true,
                              readOnly: !edit,
                              controller: bioController,
                              validator: validator),
                          InputField(
                              label: 'Industry',
                              validator: validator,
                              readOnly: true,
                              controller: TextEditingController(
                                text: industry == null ? '' : industry!.name,
                              )),
                          InputField(
                              label: 'Speciality',
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
                            label: 'Address',
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
                          Row(
                            children: [
                              Text('Education',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .copyWith(
                                          color: const Color.fromARGB(
                                              200, 158, 158, 158),
                                          fontWeight: FontWeight.normal,
                                          fontSize: 20)),
                              const Spacer(),
                              edit
                                  ? IconButton(
                                      onPressed: () {
                                        showModal(
                                          color: Theme.of(context).primaryColor,
                                          isDismissible: true,
                                          const AddEducation(),
                                          context,
                                        );
                                      },
                                      icon: const Icon(Icons.add),
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          InputField(
                            label: 'Education',
                            validator: validator,
                            readOnly: true,
                            controller: TextEditingController(
                                text: education
                                    .map((founder) => founder.degree)
                                    .join(', ')),
                            onTap: () => {
                              showModal(
                                color: Theme.of(context).primaryColor,
                                isDismissible: true,
                                EducationalBackground(
                                  educations: education,
                                  toggleHeaderColor: () {},
                                ),
                                context,
                              )
                            },
                          ),
                          Row(
                            children: [
                              Text('Experience',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .copyWith(
                                          color: const Color.fromARGB(
                                              200, 158, 158, 158),
                                          fontWeight: FontWeight.normal,
                                          fontSize: 20)),
                              const Spacer(),
                              edit
                                  ? IconButton(
                                      onPressed: () {
                                        showModal(
                                          color: Theme.of(context).primaryColor,
                                          isDismissible: true,
                                          const AddExperience(),
                                          context,
                                        );
                                      },
                                      icon: const Icon(Icons.add),
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          InputField(
                            label: 'Experience',
                            onTap: () => {
                              showModal(
                                color: Theme.of(context).primaryColor,
                                isDismissible: true,
                                JobSeekerExperience(
                                  experiences: experience,
                                  toggleHeaderColor: () {},
                                ),
                                context,
                              )
                            },
                            validator: validator,
                            readOnly: true,
                            controller: TextEditingController(
                                text: experience
                                    .map((experience) => experience.position)
                                    .join(', ')),
                          ),
                          Text('Skills',
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
                            label: 'Skills',
                            onTap: () => {
                              showModal(
                                color: Theme.of(context).primaryColor,
                                isDismissible: true,
                                SkillsAndHobbies(
                                  skills: selectedSkills as List<Skill>,
                                  toggleHeaderColor: () {},
                                ),
                                context,
                              )
                            },
                            validator: validator,
                            readOnly: !edit,
                            controller: TextEditingController(
                                text: selectedSkills
                                    .map((skill) => skill.name)
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
                    List<Map<String, dynamic>> educationsJson = education
                        .map((education) => education.toJson())
                        .toList();

                    List<Map<String, dynamic>> experiencesJson = experience
                        .map((experience) => experience.toJson())
                        .toList();

                    List<Map<String, dynamic>> certificationsJson =
                        certification
                            .map((certification) => certification.toJson())
                            .toList();

                    final data = <String, dynamic>{
                      "id": ref.read(jobSeekerProfileProvider).jobSeeker.id,
                      "user_id": ref.read(jobSeekerProfileProvider).user.id,
                      "first_name": firstNameController.text,
                      "last_name": lastNameController.text,
                      "dob": dobController.text,
                      'profilePic': base64Image.isNotEmpty ? base64Image : null,
                      'resume': resume,
                      "phone": phoneController.text,
                      "address": locationController.text,
                      "bio": bioController.text,
                      "industry_id": industry!.id,
                      "specialization_id": niche!.id,
                      'social_media_links': selectedSocialMedia,
                      'educations': educationsJson,
                      'experiences': experiencesJson,
                      'certifications': certificationsJson,
                      'hobbies': selectedHobbies,
                      "skills": selectedSkills,
                    };
                    final update = await ref
                        .read(jobSeekerProfileProvider)
                        .updateJobSeekerProfile(data);
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
