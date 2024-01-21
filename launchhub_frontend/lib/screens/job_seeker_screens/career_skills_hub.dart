import 'package:flutter/material.dart';
import 'package:launchhub_frontend/data/udemy_api.dart';
import 'package:launchhub_frontend/helpers/open_link.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/feature_card.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/header.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/section_title.dart';

class CareerSkillsHub extends StatelessWidget {
  const CareerSkillsHub({super.key, required this.specialization});

  final String specialization;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(180),
        child: Header(
          text:
              'Elevate your career with our Courses page, offering tailored skill-boosting programs for job seekers. Take the next step towards professional growth and success with our curated courses designed to empower your journey.',
          title: 'Career Skills Hub',
        ),
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Center(
          child: SizedBox(
            width: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 45),
                const SectionTitle(title: 'Related Courses'),
                FutureBuilder<List<dynamic>>(
                  future: fetchUdemyCourses(specialization),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Align(
                        child: CircularProgressIndicator(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                        ),
                      ); // Show loading indicator
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      final List<dynamic> courses = snapshot.requireData;
                      double screenHeight = MediaQuery.of(context).size.height;
                      double customHeight = screenHeight - 59;
                      return SizedBox(
                        height: customHeight,
                        child: ListView.builder(
                          shrinkWrap: true, // Add this line
                          itemCount: courses.length,
                          itemBuilder: (context, index) {
                            final course = courses[index];
                            return FeatureCard(
                                title: course['title'],
                                description: course['headline'],
                                url: course['image_240x135'],
                                external: true,
                                onTap: () {
                                  openLink(
                                    context,
                                    'https://www.udemy.com${course['url']}',
                                  );
                                });
                          },
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
