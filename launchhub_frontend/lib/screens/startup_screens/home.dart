import 'package:flutter/material.dart';
import 'package:launchhub_frontend/screens/start_screen.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/bottom_bar.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/feature_card.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/header.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/welcome_card.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(180),
        child: Header(
          title: 'Vast',
          showBackButton: false,
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
                const SizedBox(height: 25),
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
                          return const StartScreen();
                        }));
                      },
                    ),
                    FeatureCard(
                      title: 'Hire Talent',
                      description:
                          'Discover Talent Diversity: Explore Exceptional Job Seekers Tailored for Startups on Our Hiring Page',
                      imagePath: 'assets/images/guides.png',
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const StartScreen();
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
                          return const StartScreen();
                        }));
                      },
                    ),
                    FeatureCard(
                      title: 'Marketing Guides',
                      description:
                          'Craft and Elevate Your Brand: Resources for Creating and Maintaining a Strong Brand Identity for Your Startup.',
                      imagePath: 'assets/images/marketing_guides.png',
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const StartScreen();
                        }));
                      },
                    ),
                    FeatureCard(
                      title: 'Content Creators',
                      description:
                          'Discover Talent Diversity: Explore Exceptional Job Seekers Tailored for Startups on Our Hiring Page',
                      imagePath: 'assets/images/content_creators.png',
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const StartScreen();
                        }));
                      },
                    ),
                    FeatureCard(
                      title: 'Digital Marketing',
                      description:
                          'Unlock Content Success: Dive into Expert Guides for Crafting Valuable Content that Resonates with Your Online Audience.',
                      imagePath: 'assets/images/digital_marketing.png',
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const StartScreen();
                        }));
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
