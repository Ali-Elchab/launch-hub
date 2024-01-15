import 'package:flutter/material.dart';
import 'package:launchhub_frontend/models/certification.dart';
import 'package:launchhub_frontend/models/education.dart';
import 'package:launchhub_frontend/widgets/auth_widgets/education_card.dart';

class EducationsList extends StatelessWidget {
  const EducationsList({
    super.key,
    this.educations,
    this.removeEducation,
    this.removeCertification,
    this.certifications,
    this.onTap,
  });

  final List<Education>? educations;
  final void Function(Education education)? onTap;
  final Function? removeEducation;
  final Function? removeCertification;

  final List<Certification>? certifications;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemCount:
          educations != null ? educations!.length : certifications!.length,
      itemBuilder: (context, index) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Dismissible(
              key: ValueKey(index),
              direction: DismissDirection.endToStart,
              background: Container(
                color: const Color.fromARGB(255, 167, 11, 0),
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 20),
                margin: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 4,
                ),
                child: const Icon(
                  Icons.delete,
                  color: Colors.white,
                  size: 40,
                ),
              ),
              confirmDismiss: (direction) {
                return showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Are you sure?'),
                    content: const Text(
                      'Do you want to remove?',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop(false);
                        },
                        child: const Text('No'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop(true);
                        },
                        child: const Text('Yes'),
                      ),
                    ],
                  ),
                );
              },
              onDismissed: (direction) {
                educations != null
                    ? removeEducation!(educations![index])
                    : removeCertification!(certifications![index]);
              },
              child: educations != null
                  ? EducationCard(
                      education: educations![index],
                      onTap: () {},
                    )
                  : EducationCard(
                      certificationation: certifications![index],
                      onTap: () {},
                    )),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
