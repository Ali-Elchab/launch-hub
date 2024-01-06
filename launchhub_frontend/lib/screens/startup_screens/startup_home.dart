import 'package:flutter/material.dart';
import 'package:launchhub_frontend/screens/start_screen.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/bottom_bar.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/feature_card.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/header.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/section_title.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/welcome_card.dart';

class StartupHome extends StatefulWidget {
  const StartupHome({super.key});

  @override
  State<StartupHome> createState() => _StartupHomeState();
}

class _StartupHomeState extends State<StartupHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(180),
        child: Header(
          text: 'Your Premier App for Turning Visions into Reality ',
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
                const SizedBox(height: 45),
                Column(
                  children: [
                    const WelcomeCard(
                        imageUrl: 'assets/images/startup_home_main.png',
                        text:
                            'Welcome to Startup Assistance Hub – your go-to resource for hiring, marketing, legal, and finance success. Explore tailored features to elevate your startup journey.'),
                    const SizedBox(height: 25),
                    const SectionTitle(title: 'Hiring'),
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
                      imagePath: 'assets/images/hire_talent.png',
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
                    const SectionTitle(title: 'Marketing'),
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
                    const SectionTitle(title: 'Finance'),
                    FeatureCard(
                      title: 'Financial Planning',
                      description:
                          'Financial Mastery Hub: Tools for Budgeting, Forecasting, and Financial Analysis to Empower Your Startup\'s Fiscal Planning.',
                      imagePath: 'assets/images/financial_planning.png',
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const StartScreen();
                        }));
                      },
                    ),
                    FeatureCard(
                      title: 'Financial Advisors',
                      description:
                          'Navigate Financial Success: Connect with Expert Financial Advisors Tailored for Startups to Drive Strategic Growth.',
                      imagePath: 'assets/images/financial_advisors.png',
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const StartScreen();
                        }));
                      },
                    ),
                    const SectionTitle(title: 'Legal'),
                    FeatureCard(
                      title: 'Legal Guides',
                      description:
                          'Legal Wisdom Hub: Dive into Articles and Resources Covering Crucial Legal Issues Tailored for Startups.',
                      imagePath: 'assets/images/legal_guides.png',
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const StartScreen();
                        }));
                      },
                    ),
                    FeatureCard(
                      title: 'Legal Advisors',
                      description:
                          'Startup Legal Expertise: Connect with Specialized Legal Advisors to Safeguard and Propel Your Startup\'s Success.',
                      imagePath: 'assets/images/legal_advisors.png',
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const StartScreen();
                        }));
                      },
                    ),
                    FeatureCard(
                      title: 'Contract Templates',
                      description:
                          'Seamless Contracting: Explore our Library of Ready-to-Use Templates for Common Business Contracts, Tailored for Your Convenience.',
                      imagePath: 'assets/images/contract_templates.png',
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
