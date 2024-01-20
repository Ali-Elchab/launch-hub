import 'package:flutter/material.dart';
import 'package:launchhub_frontend/helpers/show_modal_sheet.dart';
import 'package:launchhub_frontend/models/job_post.dart';
import 'package:launchhub_frontend/models/startup.dart';
import 'package:launchhub_frontend/widgets/job_seeker_widgets/startup_profile_modal.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/bottom_bar.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/profile_header.dart';
import 'package:launchhub_frontend/widgets/submit_button.dart';

class JobPostView extends StatefulWidget {
  const JobPostView({super.key, required this.jobPost, required this.startup});

  final JobPost jobPost;
  final Startup startup;

  @override
  State<JobPostView> createState() => _JobPostViewState();
}

class _JobPostViewState extends State<JobPostView> {
  bool showingModal = false;

  void _toggleHeaderColor() => setState(() {
        showingModal = !showingModal;
      });

  @override
  Widget build(BuildContext context) {
    final startup = widget.startup;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(180),
        child: ProfileHeader(
          companyName: startup.companyName,
          city: startup.companyAddress,
          email: startup.companyEmail,
          phoneNumber: startup.companyPhone,
          socials: startup.socialMediaLinks,
          profilePicture: startup.copmanyLogo,
          color: showingModal ? Colors.black : Colors.white,
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
                child: SingleChildScrollView(
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
                      const SizedBox(height: 15),
                      RichText(
                        text: TextSpan(
                          style: Theme.of(context).textTheme.bodyMedium,
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Experience Level: ',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(fontWeight: FontWeight.bold)),
                            TextSpan(
                              text: widget.jobPost.experienceLevel,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      RichText(
                        text: TextSpan(
                          style: Theme.of(context).textTheme.bodyMedium,
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Education Level: ',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(fontWeight: FontWeight.bold)),
                            TextSpan(
                              text: widget.jobPost.educationLevel,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      RichText(
                        text: TextSpan(
                          style: Theme.of(context).textTheme.bodyMedium,
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Job Qualifications: ',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(fontWeight: FontWeight.bold)),
                            TextSpan(
                              text: widget.jobPost.jobQualification,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      RichText(
                        text: TextSpan(
                          style: Theme.of(context).textTheme.bodyMedium,
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Application Deadline: ',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(fontWeight: FontWeight.bold)),
                            TextSpan(
                              text: widget.jobPost.deadline,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        margin: const EdgeInsets.only(bottom: 75),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () {
                                _toggleHeaderColor();
                                showModal(
                                  StartupProfileModal(
                                    toggleHeaderColor: _toggleHeaderColor,
                                    qualifications:
                                        widget.jobPost.jobQualification,
                                    skills: widget.jobPost.requiredSkills,
                                  ),
                                  context,
                                  color: Theme.of(context).colorScheme.primary,
                                  enableDrag: false,
                                  isDismissible: false,
                                );
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
                                            'assets/images/requirements.png'),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Requirements',
                                    textAlign: TextAlign.center,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  )
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                _toggleHeaderColor();
                                showModal(
                                  StartupProfileModal(
                                    toggleHeaderColor: _toggleHeaderColor,
                                    responsibilities:
                                        widget.jobPost.responsibilities,
                                  ),
                                  context,
                                  color: Theme.of(context).colorScheme.primary,
                                  enableDrag: false,
                                  isDismissible: false,
                                );
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
                                            'assets/images/responsibilities.png'),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Responsibilities',
                                    textAlign: TextAlign.center,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SubmitButton('Submit Application', () {}),
              const SizedBox(height: 20)
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(user: 'jobseeker'),
    );
  }
}
