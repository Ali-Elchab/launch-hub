import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:launchhub_frontend/helpers/navigator.dart';
import 'package:launchhub_frontend/providers/jobseeker_register_provider.dart';
import 'package:launchhub_frontend/screens/auth_screens/hobbies.dart';
import 'package:launchhub_frontend/widgets/auth_widgets/bottom_text.dart';
import 'package:launchhub_frontend/widgets/auth_widgets/choice_chip.dart';
import 'package:launchhub_frontend/widgets/custom_appbar.dart';
import 'package:launchhub_frontend/widgets/small_button.dart';

class Skills extends ConsumerStatefulWidget {
  const Skills({super.key});

  @override
  ConsumerState<Skills> createState() => _SkillsState();
}

class _SkillsState extends ConsumerState<Skills> {
  @override
  void initState() {
    ref.read(jobSeekerRegisterProvider.notifier).getSkills();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final provider = ref.watch(jobSeekerRegisterProvider);
    final providerNotifier = ref.read(jobSeekerRegisterProvider.notifier);
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
                    'Skills',
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
                    'Highlight your strengths and abilities for others to see and recognize.',
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
                          children: providerNotifier.skills
                              .map((skill) => ChoiceTag(
                                    label: skill.name,
                                    isSelected: provider.selectedSkills
                                        .contains(skill.id),
                                    onSelected: () =>
                                        providerNotifier.toggleSkill(skill),
                                  ))
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ),
                SmallButton('Next', () {
                  navigator(context, const Hobbies());
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
