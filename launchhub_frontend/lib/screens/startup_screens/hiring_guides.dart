import 'package:flutter/material.dart';
import 'package:launchhub_frontend/data/udemy_api.dart';
import 'package:launchhub_frontend/helpers/open_link.dart';
import 'package:launchhub_frontend/helpers/show_modal_sheet.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/bottom_bar.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/feature_card.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/header.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/section_title.dart';
import 'package:launchhub_frontend/widgets/startup/interview_questions.dart';

class HiringGuides extends StatelessWidget {
  const HiringGuides({super.key, required this.niche});

  final String niche;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(180),
        child: Header(
          text:
              'From crafting effective job descriptions to conducting successful interviews, we\'ve got you covered with practical resources for building your dream team. ',
          title: 'Guides & Templates',
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
                const SectionTitle(title: 'Featured Templates'),
                const SizedBox(height: 10),
                FeatureCard(
                  title: 'Interview Questions',
                  description:
                      'This template offers a curated set of insightful interview questions designed to assess candidates thoroughly and make informed hiring decisions.',
                  imagePath: 'assets/images/interview-questions.png',
                  onTap: () {
                    showModal(
                      const InterviewQuestions(),
                      context,
                      color: Theme.of(context).colorScheme.primary,
                      enableDrag: false,
                      isDismissible: false,
                    );
                  },
                ),
                FeatureCard(
                  title: 'Hiring Process',
                  description:
                      'Streamline your hiring process with this checklist template, ensuring a systematic and efficient approach to recruitment.',
                  imagePath: 'assets/images/hiring-process.png',
                  onTap: () {
                    downloadFile(
                        'https://hr.berkeley.edu/sites/default/files/attachments/Hiring_Process_Checklist.pdf',
                        'Hiring Process Template');
                  },
                ),
                FeatureCard(
                  title: 'Reference Check',
                  description:
                      'This template streamlines the reference-checking process, enabling a comprehensive evaluation of a candidate\'s professional background.',
                  imagePath: 'assets/images/reference-check.png',
                  onTap: () {
                    openLink(context,
                        'https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=&ved=2ahUKEwjorpeDudKDAxWhywIHHUp7BL4QFnoECBMQAQ&url=https%3A%2F%2Fwww.fairwork.gov.au%2Fsites%2Fdefault%2Ffiles%2Fmigration%2F766%2FReference-checking-form.docx&usg=AOvVaw1TA-0PyC8aY6Xu3AozapNu&opi=89978449');
                  },
                ),
                const SizedBox(height: 25),
                const SectionTitle(title: 'Related Courses'),
                const SizedBox(height: 10),
                FutureBuilder<List<dynamic>>(
                  future: fetchUdemyCourses(niche),
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
                      double customHeight = screenHeight - 500;
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
                                    'www.udemy.com${course['url']}',
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
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
