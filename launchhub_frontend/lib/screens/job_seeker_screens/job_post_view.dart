import 'package:flutter/material.dart';
import 'package:launchhub_frontend/data/mockData.dart';
import 'package:launchhub_frontend/models/job_post.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/bottom_bar.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/profile_header.dart';
import 'package:launchhub_frontend/widgets/startup/skills_and_hobbies.dart';

class JobPostView extends StatefulWidget {
  const JobPostView({super.key, required this.jobPost});

  final JobPost jobPost;

  @override
  State<JobPostView> createState() => _JobPostViewState();
}

class _JobPostViewState extends State<JobPostView> {
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
    final startup = dummyStartups
        .where((startup) => startup.id == widget.jobPost.startupId)
        .first;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(180),
        child: ProfileHeader(
          firstName: startup.companyName,
          city: startup.companyCity,
          email: startup.companyEmail,
          phoneNumber: startup.companyPhone,
          socials: startup.socialMediaLinks,
          profilePicture: startup.copmanyLogo,
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
                    Text(widget.jobPost.jobTitle,
                        style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 20),
                    Text(
                      widget.jobPost.jobDescription,
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 20),
                    RichText(
                      text: TextSpan(
                        style: Theme.of(context).textTheme.bodyMedium,
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Job Type: ',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(fontWeight: FontWeight.bold)),
                          TextSpan(
                            text: widget.jobPost.jobType,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      widget.jobPost.jobType,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      'Experienc Level:\n${widget.jobPost.experienceLevel},',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      'Experienc Level:\n${widget.jobPost.educationLevel}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      'Experienc Level:\n${widget.jobPost.experienceLevel},',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
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
                                skills: widget.jobPost.requiredSkills,
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
                              // _showModal();
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
                            onTap: () {
                              _toggleHeaderColor();
                              // _showModal();
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
