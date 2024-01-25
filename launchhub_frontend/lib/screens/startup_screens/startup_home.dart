import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:launchhub_frontend/data/static_data.dart';
import 'package:launchhub_frontend/helpers/navigator.dart';
import 'package:launchhub_frontend/providers/data_provider.dart';
import 'package:launchhub_frontend/providers/startup_profile_provider.dart';
import 'package:launchhub_frontend/screens/startup_screens/advisors.dart';
import 'package:launchhub_frontend/screens/startup_screens/hire_talent.dart';
import 'package:launchhub_frontend/screens/startup_screens/hiring_guides.dart';
import 'package:launchhub_frontend/screens/startup_screens/job_board.dart';
import 'package:launchhub_frontend/screens/startup_screens/articles_and_templates.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/feature_card.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/header.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/section_title.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/welcome_card.dart';

class StartupHome extends ConsumerStatefulWidget {
  const StartupHome({super.key});

  @override
  ConsumerState<StartupHome> createState() => _StartupHomeState();
}

class _StartupHomeState extends ConsumerState<StartupHome> {
  @override
  void initState() {
    final nicheId = ref.read(startupProfileProvider).startup.specializationId;
    ref.read(dataProvider.notifier).getNicheName(nicheId);
    ref.read(dataProvider.notifier).getAdvisors();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final startupProfile = ref.read(startupProfileProvider);
    final data = ref.watch(dataProvider);
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(180),
          child: Header(
            text: startupProfile.startup.companyDescription,
            title: startupProfile.startup.companyName,
            showBackButton: false,
          ),
        ),
        body: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.73,
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
                        onTap: () async {
                          navigator(context, const JobBoard());
                        },
                      ),
                      FeatureCard(
                        title: 'Hire Talent',
                        description:
                            'Discover Talent Diversity: Explore Exceptional Job Seekers Tailored for Startups on Our Hiring Page',
                        imagePath: 'assets/images/hire_talent.png',
                        onTap: () async {
                          navigator(context, const HireTalent());
                        },
                      ),
                      FeatureCard(
                        title: 'Guides And Templates',
                        description:
                            'Build Your Dream Team: Comprehensive Guides and Templates for Crafting Effective Job Descriptions and Conducting Successful Interviews.',
                        imagePath: 'assets/images/guides.png',
                        onTap: () {
                          navigator(
                              context,
                              HiringGuides(
                                niche: data.nicheName,
                              ));
                        },
                      ),
                      const SectionTitle(title: 'Marketing'),
                      FeatureCard(
                        title: 'Marketing Guides',
                        description:
                            'Craft and Elevate Your Brand: Resources for Creating and Maintaining a Strong Brand Identity for Your Startup.',
                        imagePath: 'assets/images/marketing_guides.png',
                        onTap: () {
                          navigator(
                              context,
                              ArticlesAndTemplates(
                                templates: marketingTemplates,
                                query: 'marketing startup business',
                                title: 'Marketing Guides',
                                text:
                                    'Empower your startup\'s brand identity with essential resources on our Branding page, offering insightful articles and practical templates. Craft and elevate your brand with ease.',
                              ));
                        },
                      ),
                      FeatureCard(
                        title: 'Content Creators',
                        description:
                            'Discover Talent Diversity: Explore Exceptional Job Seekers Tailored for Startups on Our Hiring Page',
                        imagePath: 'assets/images/content_creators.png',
                        onTap: () async {
                          navigator(
                            context,
                            const Advisors(
                                category: 'marketing',
                                title: 'Content Creators',
                                text:
                                    "Explore our Content Creators Page—a hub connecting startups with talented content professionals. Elevate your brand with engaging content and strategic marketing. Find the perfect creator to bring your vision to life."),
                          );
                        },
                      ),
                      const SectionTitle(title: 'Finance'),
                      FeatureCard(
                        title: 'Financial Planning',
                        description:
                            'Financial Mastery Hub: Tools for Budgeting, Forecasting, and Financial Analysis to Empower Your Startup\'s Fiscal Planning.',
                        imagePath: 'assets/images/financial_planning.png',
                        onTap: () {
                          navigator(
                            context,
                            ArticlesAndTemplates(
                              templates: marketingTemplates,
                              query: 'marketing startup business',
                              title: 'Marketing Guides',
                              text:
                                  'Empower your startup\'s brand identity with essential resources on our Branding page, offering insightful articles and practical templates. Craft and elevate your brand with ease.',
                            ),
                          );
                        },
                      ),
                      FeatureCard(
                        title: 'Financial Advisors',
                        description:
                            'Navigate Financial Success: Connect with Expert Financial Advisors Tailored for Startups to Drive Strategic Growth.',
                        imagePath: 'assets/images/financial_advisors.png',
                        onTap: () {
                          navigator(
                            context,
                            const Advisors(
                                category: 'finance',
                                title: 'Financial Advisors',
                                text:
                                    "Discover a curated list of financial advisors tailored for startups. Choose from experienced professionals and engage in direct conversations to address your financial queries, providing personalized guidance for your startup's fiscal success."),
                          );
                        },
                      ),
                      const SectionTitle(title: 'Legal'),
                      FeatureCard(
                        title: 'Legal Guides',
                        description:
                            'Legal Wisdom Hub: Dive into Articles and Resources Covering Crucial Legal Issues Tailored for Startups.',
                        imagePath: 'assets/images/legal_guides.png',
                        onTap: () {
                          navigator(
                            context,
                            ArticlesAndTemplates(
                              templates: legalTemplates,
                              query: 'legal for startup businesses',
                              title: 'Legal Guides',
                              text:
                                  'Explore our Financial Planning page for budgeting, forecasting, and financial analysis tools. Empower your startup\'s fiscal planning with streamlined templates and checklists.',
                            ),
                          );
                        },
                      ),
                      FeatureCard(
                        title: 'Legal Advisors',
                        description:
                            'Startup Legal Expertise: Connect with Specialized Legal Advisors to Safeguard and Propel Your Startup\'s Success.',
                        imagePath: 'assets/images/legal_advisors.png',
                        onTap: () {
                          navigator(
                            context,
                            const Advisors(
                                category: 'legal',
                                title: 'Legal Advisors',
                                text:
                                    "Discover a curated list of Legal Advisors on our platform, offering startups personalized guidance on key legal matters. Connect, chat, and get tailored advice for your business needs."),
                          );
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
