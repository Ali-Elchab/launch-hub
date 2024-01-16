import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:launchhub_frontend/data/mock_data.dart';
import 'package:launchhub_frontend/providers/jobseeker_register_provider.dart';
import 'package:launchhub_frontend/widgets/auth_widgets/bottom_text.dart';
import 'package:launchhub_frontend/widgets/auth_widgets/choice_chip.dart';
import 'package:launchhub_frontend/widgets/custom_appbar.dart';
import 'package:launchhub_frontend/widgets/small_button.dart';

class Hobbies extends ConsumerStatefulWidget {
  const Hobbies({super.key});

  @override
  ConsumerState<Hobbies> createState() => _HobbiesState();
}

class _HobbiesState extends ConsumerState<Hobbies> {
  @override
  void initState() {
    ref.read(jobSeekerRegisterProvider.notifier).getHobbies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(jobSeekerRegisterProvider);
    final providerNotifier = ref.read(jobSeekerRegisterProvider.notifier);
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
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Hobbies',
                    textAlign: TextAlign.left,
                    style: textTheme.titleLarge,
                  ),
                ),
                const SizedBox(height: 35),
                ClipOval(
                  child: provider.selectedImage != null
                      ? Image.file(File(provider.selectedImage!.path),
                          width: 120, height: 120, fit: BoxFit.cover)
                      : Image.asset('assets/logos/default-profile.png',
                          width: 120, height: 120, fit: BoxFit.cover),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: Text(
                    style: textTheme.bodySmall!,
                    'Showcase your passions and interests to connect and share with like-minded individuals.',
                    textAlign: TextAlign.left,
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Wrap(
                          spacing: 9.0,
                          runSpacing: 4.0,
                          children: mockHobbies
                              .map((hobby) => ChoiceTag(
                                    label: hobby.name,
                                    isSelected: provider.selectedHobbies
                                        .contains(hobby),
                                    onSelected: () =>
                                        providerNotifier.togglehobby(hobby),
                                  ))
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ),
                SmallButton('Submit', () {
                  providerNotifier.registerJobSeeker();
                  provider.isRegistered
                      ? Navigator.pushNamedAndRemoveUntil(
                          context, '/JobSeekerHome', (route) => false)
                      : ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('Error: ${provider.errorMessage}')),
                        );
                }, showArrow: false),
                const SizedBox(height: 15),
                const BottomText(
                    text:
                        'Your provided details will be utilized to shape a personalized resume, presenting your unique hobbys and experiences to startups seeking candidates like you.'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
