import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:launchhub_frontend/models/industry.dart';
import 'package:launchhub_frontend/models/job_seeker.dart';
import 'package:launchhub_frontend/models/niche.dart';
import 'package:launchhub_frontend/providers/data_provider.dart';
import 'package:launchhub_frontend/providers/hire_talent_provider.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/profile_header.dart';
import 'package:launchhub_frontend/helpers/show_modal_sheet.dart';
import 'package:launchhub_frontend/widgets/startup/skills_and_hobbies.dart';
import 'package:launchhub_frontend/widgets/startup/educational_background.dart';
import 'package:launchhub_frontend/widgets/startup/experience.dart';

class JobSeekerProfile extends ConsumerStatefulWidget {
  const JobSeekerProfile({super.key, required this.jobSeeker});

  final JobSeeker jobSeeker;

  @override
  ConsumerState<JobSeekerProfile> createState() => _JobSeekerProfileState();
}

class _JobSeekerProfileState extends ConsumerState<JobSeekerProfile> {
  bool isShowModal = false;
  Industry? industry;
  Niche? specialization;
  @override
  void initState() {
    ref
        .read(hireTalentProvider.notifier)
        .getJobSeekerProfile(widget.jobSeeker.id);
    industry = ref
        .read(dataProvider)
        .industries
        .firstWhere((element) => element.id == widget.jobSeeker.industryId);

    specialization = ref
        .read(dataProvider)
        .niches
        .where((element) => element.id == widget.jobSeeker.specializationId)
        .first;

    super.initState();
  }

  void _toggleHeaderColor() => setState(() {
        isShowModal = !isShowModal;
      });

  @override
  Widget build(BuildContext context) {
    final details = ref.watch(hireTalentProvider);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(180),
        child: ProfileHeader(
          firstName: widget.jobSeeker.firstName,
          lastName: widget.jobSeeker.lastName,
          city: widget.jobSeeker.address,
          email: widget.jobSeeker.firstName,
          phoneNumber: widget.jobSeeker.phone,
          socials: details.socialMediaLinks,
          profilePicture: widget.jobSeeker.profilePic,
          color: isShowModal ? Colors.black : Colors.white,
        ),
      ),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.73,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 45),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(specialization!.name,
                        style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 20),
                    Text(
                      widget.jobSeeker.bio,
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
                              showModal(
                                  color: Theme.of(context).primaryColor,
                                  isDismissible: true,
                                  enableDrag: false,
                                  SkillsAndHobbies(
                                    toggleHeaderColor: () {
                                      _toggleHeaderColor();
                                    },
                                    skills: details.skills,
                                  ),
                                  context);
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
                              showModal(
                                  color: Theme.of(context).primaryColor,
                                  isDismissible: true,
                                  enableDrag: false,
                                  EducationalBackground(
                                    toggleHeaderColor: () {
                                      _toggleHeaderColor();
                                    },
                                    educations: details.educations,
                                  ),
                                  context);
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
                              showModal(
                                  color: Theme.of(context).primaryColor,
                                  isDismissible: true,
                                  enableDrag: false,
                                  JobSeekerExperience(
                                    toggleHeaderColor: () {
                                      _toggleHeaderColor();
                                    },
                                    experiences: details.experiences,
                                  ),
                                  context);
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
    );
  }
}
