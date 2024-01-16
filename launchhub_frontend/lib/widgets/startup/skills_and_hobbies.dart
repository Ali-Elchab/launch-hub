import 'package:flutter/material.dart';
import 'package:launchhub_frontend/models/skill.dart';
import 'package:launchhub_frontend/widgets/auth_widgets/choice_chip.dart';

class SkillsAndHobbies extends StatelessWidget {
  const SkillsAndHobbies(
      {super.key, required this.toggleHeaderColor, required this.skills});

  final Function()? toggleHeaderColor;
  final List<Skill>? skills;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double customHeight = screenHeight - 200;
    return Container(
      height: customHeight,
      padding: const EdgeInsets.fromLTRB(32, 20, 32, 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Skills and Hobbies',
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: const Color.fromARGB(255, 255, 255, 255))),
              IconButton(
                  onPressed: () {
                    toggleHeaderColor!();
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close),
                  color: const Color.fromARGB(255, 255, 255, 255)),
            ],
          ),
          const SizedBox(height: 24),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Wrap(spacing: 9.0, runSpacing: 4.0, children: [
                  ...skills!.map((skill) => ChoiceTag(
                        label: skill.name,
                        isSelected: false,
                      )),
                ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
