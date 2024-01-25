// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:launchhub_frontend/helpers/navigator.dart';
import 'package:launchhub_frontend/providers/data_provider.dart';
import 'package:launchhub_frontend/providers/job_seeker_profile_provider.dart';
import 'package:launchhub_frontend/screens/job_seeker_screens/career_skills_hub.dart';
import 'package:launchhub_frontend/screens/job_seeker_screens/job_opportunities.dart';
import 'package:launchhub_frontend/screens/job_seeker_screens/trending.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/feature_card.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/header.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/welcome_card.dart';

class JobSeekerHome extends ConsumerStatefulWidget {
  const JobSeekerHome({super.key});

  @override
  ConsumerState<JobSeekerHome> createState() => _JobSeekerHomeState();
}

class _JobSeekerHomeState extends ConsumerState<JobSeekerHome> {
  @override
  void initState() {
    super.initState();
    final nicheId =
        ref.read(jobSeekerProfileProvider).jobSeeker.specializationId;
    ref.read(dataProvider.notifier).getNicheName(nicheId);
  }

  @override
  Widget build(BuildContext context) {
    final jobseeker = ref.read(jobSeekerProfileProvider);
    final data = ref.watch(dataProvider);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(180),
        child: Header(
          text: 'Unlock Your Gateway to Career Success ',
          title:
              '${jobseeker.jobSeeker.firstName} ${jobseeker.jobSeeker.lastName}',
          showBackButton: false,
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.73,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 35),
                const WelcomeCard(
                    imageUrl: 'assets/images/jobseeker_home_main.png',
                    text:
                        'Welcome to Career Advancement Hub – Your resource for professional success. Explore our features to enhance your career journey.'),
                const SizedBox(height: 25),
                Column(
                  children: [
                    FeatureCard(
                      title: 'Job Opportunities',
                      description:
                          'Explore Endless Opportunities: Your Gateway to Exciting Job Offers Awaits! Discover Your Next Career Move with our Diverse Range of Job Listings.',
                      imagePath: 'assets/images/job_opportunities.png',
                      onTap: () async {
                        await jobseeker.fetchJobPosts();
                        navigator(context, const JobOpportunities());
                      },
                    ),
                    FeatureCard(
                      title: 'Career Skills Hub',
                      description:
                          'Boost Your Skills: Tailored Courses for Job Seekers Ready to Elevate Their Careers. Take the Next Step Toward Professional Growth and Success.',
                      imagePath: 'assets/images/career-skills.png',
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return CareerSkillsHub(
                              specialization: data.nicheName);
                        }));
                      },
                    ),
                    FeatureCard(
                      title: 'Trending',
                      description:
                          'Navigate Your Career Journey: Essential Guides and Articles for Job Seekers, Covering Interviews, Resumes, and Beyond. Empowering You with Expert Insights for Success.',
                      imagePath: 'assets/images/trending.png',
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Trending(specialization: data.nicheName);
                        }));
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
