import 'package:flutter/material.dart';
import 'package:launchhub_frontend/models/course.dart';
import 'package:launchhub_frontend/models/education.dart';
import 'package:launchhub_frontend/widgets/auth_widgets/education_card.dart';

class EducationsList extends StatelessWidget {
  const EducationsList({
    super.key,
    this.educations,
    this.removeEducation,
    this.removeCourse,
    this.courses,
    this.onTap,
  });

  final List<Education>? educations;
  final void Function(Education education)? onTap;
  final void Function(Education education)? removeEducation;
  final void Function(Course course)? removeCourse;
  final List<Course>? courses;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: educations != null ? educations!.length : courses!.length,
      itemBuilder: (context, index) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Dismissible(
              key: ValueKey(
                educations != null ? educations![index].id : courses![index].id,
              ),
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
                    : removeCourse!(courses![index]);
              },
              child: educations != null
                  ? EducationCard(
                      education: educations![index],
                      onTap: () {},
                    )
                  : EducationCard(
                      course: courses![index],
                      onTap: () {},
                    )),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
