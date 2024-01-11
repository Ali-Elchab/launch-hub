import 'package:flutter/material.dart';
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
            text: 'Your Premier App for Turning Visions into Reality ',
            title: 'Ahmad Hmad',
            showBackButton: false,
          ),
        ),
        body: Center(
          child: SizedBox(
            width: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 45),
                Column(
                  children: [
                    const WelcomeCard(
                        imageUrl: 'assets/images/startup_home_main.png',
                        text:
                            'Welcome to Startup Assistance Hub – your go-to resource for hiring, marketing, legal, and finance success. Explore tailored features to elevate your startup journey.'),
                    const SizedBox(height: 25),
                    FeatureCard(
                      title: 'Job Board',
                      description:
                          'Empower Your Team\'s Growth: Effortlessly Add, View, and Manage Job Listings to Connect with Top Talent and Shape Your Company\'s Future.',
                      imagePath: 'assets/images/job_board.png',
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const JobBoard();
                        }));
                      },
                    ),
                    FeatureCard(
                      title: 'Hire Talent',
                      description:
                          'Discover Talent Diversity: Explore Exceptional Job Seekers Tailored for Startups on Our Hiring Page',
                      imagePath: 'assets/images/hire_talent.png',
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const HireTalent();
                        }));
                      },
                    ),
                    FeatureCard(
                      title: 'Guides And Templates',
                      description:
                          'Build Your Dream Team: Comprehensive Guides and Templates for Crafting Effective Job Descriptions and Conducting Successful Interviews.',
                      imagePath: 'assets/images/guides.png',
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const HiringGuides();
                        }));
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: const CustomBottomNavigationBar());
  }
}
