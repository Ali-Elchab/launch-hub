import 'package:flutter/material.dart';
import 'package:launchhub_frontend/screens/job_seeker_screens/job_opportunities.dart';
import 'package:launchhub_frontend/screens/startup_screens/hire_talent.dart';
import 'package:launchhub_frontend/screens/startup_screens/hiring_guides.dart';
import 'package:launchhub_frontend/screens/startup_screens/job_board.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/bottom_bar.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/feature_card.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/header.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/welcome_card.dart';

class JobSeekerHome extends StatelessWidget {
  const JobSeekerHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(180),
          child: Header(
            text: 'Unlock Your Gateway to Career Success ',
            title: 'Ahmad Ahmad',
            showBackButton: false,
          ),
        ),
        body: Center(
          child: SizedBox(
            width: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 35),
                const WelcomeCard(
                    imageUrl: 'assets/images/jobseeker_home_main.png',
                    text:
                        'Welcome to Career Advancement Hub – Your resource for professional success. Explore our features to enhance your career journey.'),
                const SizedBox(height: 25),
                FeatureCard(
                  title: 'Job Opportunities',
                  description:
                      'Explore Endless Opportunities: Your Gateway to Exciting Job Offers Awaits! Discover Your Next Career Move with our Diverse Range of Job Listings.',
                  imagePath: 'assets/images/job_opportunities.png',
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const JobOpportunities();
                    }));
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
                      return const HireTalent();
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
                      return const HiringGuides();
                    }));
                  },
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: const CustomBottomNavigationBar());
  }
}
