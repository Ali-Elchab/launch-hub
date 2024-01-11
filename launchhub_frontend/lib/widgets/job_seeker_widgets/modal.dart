import 'package:flutter/material.dart';
import 'package:launchhub_frontend/models/skill.dart';
import 'package:launchhub_frontend/widgets/auth_widgets/choice_chip.dart';

class Modal extends StatelessWidget {
  const Modal(
      {super.key,
      required this.toggleHeaderColor,
      this.skills,
      this.qualifications,
      this.responsibilities});

  final Function()? toggleHeaderColor;
  final String? qualifications;
  final String? responsibilities;
  final List<Skill>? skills;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double customHeight = screenHeight - 200;
    return Container(
      height: customHeight,
      padding: const EdgeInsets.fromLTRB(32, 20, 32, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                  qualifications != null
                      ? 'Qualifications'
                      : responsibilities != null
                          ? 'Responsibilities'
                          : '',
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
          const SizedBox(height: 10),
          Text(qualifications ?? responsibilities ?? '',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: const Color.fromARGB(255, 255, 255, 255),
                  )),
          const SizedBox(height: 30),
          if (skills != null) ...[
            Text(
              'Required Skills',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(color: const Color.fromARGB(255, 255, 255, 255)),
            ),
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
          ]
        ],
      ),
    );
  }
}
