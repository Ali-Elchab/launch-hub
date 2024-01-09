import 'package:flutter/material.dart';
import 'package:launchhub_frontend/models/jobSeeker.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/bottom_bar.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/profile_header.dart';
import 'package:launchhub_frontend/widgets/startup/educational_background.dart';
import 'package:launchhub_frontend/widgets/startup/skills&hobbies.dart';

class JobSeekerProfile extends StatefulWidget {
  const JobSeekerProfile({super.key, required this.jobSeeker});

  final JobSeeker jobSeeker;

  @override
  State<JobSeekerProfile> createState() => _JobSeekerProfileState();
}

class _JobSeekerProfileState extends State<JobSeekerProfile> {
  bool showModal = false;

  void _showModal(Widget widget) {
    showModalBottomSheet(
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 0,
        isScrollControlled: true,
        context: context,
        isDismissible: true,
        enableDrag: false,
        barrierColor: Colors.transparent,
        builder: (ctx) => widget);
  }

  void _toggleHeaderColor() => setState(() {
        showModal = !showModal;
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(180),
        child: ProfileHeader(
          firstName: widget.jobSeeker.firstName,
          lastName: widget.jobSeeker.lastName,
          city: widget.jobSeeker.city,
          email: widget.jobSeeker.firstName,
          phoneNumber: widget.jobSeeker.phone,
          socials: widget.jobSeeker.socialMediaLinks,
          profilePicture: widget.jobSeeker.profilePic,
          color: showModal ? Colors.black : Colors.white,
        ),
      ),
      body: Center(
        child: SizedBox(
          width: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 45),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.jobSeeker.specializationId.name,
                        style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 20),
                    Text(
                      widget.jobSeeker.proffesionalSummary,
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.justify,
                    ),
                    const Spacer(),
                    Container(
                      margin: const EdgeInsets.only(bottom: 75),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              _toggleHeaderColor();
                              _showModal(SkillsAndHobbies(
                                toggleHeaderColor: () {
                                  _toggleHeaderColor();
                                },
                                skills: widget.jobSeeker.skills,
                              ));
                            },
                            child: Column(
                              children: [
                                Container(
                                  width: 85,
                                  height: 85,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: const DecorationImage(
                                      image: AssetImage(
                                          'assets/images/skillshobbies.jpeg'),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  'Skills\n&\nHobbies',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                )
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              _toggleHeaderColor();
                              _showModal(EducationalBackground(
                                toggleHeaderColor: () {
                                  _toggleHeaderColor();
                                },
                                educations: widget.jobSeeker.educations,
                              ));
                            },
                            child: Column(
                              children: [
                                Container(
                                  width: 85,
                                  height: 85,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: const DecorationImage(
                                      image: AssetImage(
                                          'assets/images/educationalbg.jpeg'),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Educational\nBackground',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                )
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Column(
                              children: [
                                Container(
                                  width: 85,
                                  height: 85,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: const DecorationImage(
                                      image: AssetImage(
                                          'assets/images/experience.jpeg'),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Work\nExperience',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
