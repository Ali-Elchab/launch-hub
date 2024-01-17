import 'package:flutter/material.dart';
import 'package:launchhub_frontend/data/mock_data.dart';
import 'package:launchhub_frontend/models/skill.dart';
import 'package:launchhub_frontend/widgets/auth_widgets/choice_chip.dart';

class PickSkills extends StatefulWidget {
  const PickSkills({super.key, this.selectedSkills});

  final List? selectedSkills;

  @override
  State<PickSkills> createState() => _PickSkillsState();
}

class _PickSkillsState extends State<PickSkills> {
  void toggleSkill(Skill skill) {
    setState(() {
      if (widget.selectedSkills!.contains(skill)) {
        widget.selectedSkills!.remove(skill);
      } else {
        widget.selectedSkills!.add(skill);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Wrap(spacing: 9.0, runSpacing: 4.0, children: [
        Container(
            margin: const EdgeInsets.only(bottom: 10),
            width: double.infinity,
            child: Text('Pick skills:',
                style: Theme.of(context).textTheme.titleMedium!)),
        ...mockSkills.map((skill) => ChoiceTag(
              label: skill.name,
              isSelected: widget.selectedSkills!.contains(skill),
              onSelected: () => toggleSkill(skill),
            )),
      ]),
    );
  }
}
