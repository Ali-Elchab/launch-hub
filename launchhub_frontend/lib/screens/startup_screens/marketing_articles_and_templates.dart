import 'package:flutter/material.dart';
import 'package:launchhub_frontend/data/articles_api.dart';
import 'package:launchhub_frontend/data/udemy_api.dart';
import 'package:launchhub_frontend/helpers/open_link.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/bottom_bar.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/feature_card.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/header.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/section_title.dart';
import 'package:launchhub_frontend/widgets/startup/interview_questions.dart';

class MarketingArticlesAndTemplates extends StatefulWidget {
  const MarketingArticlesAndTemplates({super.key});

  @override
  State<MarketingArticlesAndTemplates> createState() =>
      _MarketingArticlesAndTemplatesState();
}

class _MarketingArticlesAndTemplatesState
    extends State<MarketingArticlesAndTemplates> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(180),
        child: Header(
          text:
              'Empower your startup\'s brand identity with essential resources on our Branding page, offering insightful articles and practical templates. Craft and elevate your brand with ease.',
          title: 'Marketing Guides',
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
                const SectionTitle(title: 'Featured Templates'),
                const SizedBox(height: 10),
                FeatureCard(
                  title: 'Interview Questions',
                  description:
                      'This template offers a curated set of insightful interview questions designed to assess candidates thoroughly and make informed hiring decisions.',
                  imagePath: 'assets/images/interview-questions.png',
                  onTap: () {
                    _showModal(InterviewQuestions());
                  },
                ),
                FeatureCard(
                  title: 'Hiring Process',
                  description:
                      'Streamline your hiring process with this checklist template, ensuring a systematic and efficient approach to recruitment.',
                  imagePath: 'assets/images/hiring-process.png',
                  onTap: () {
                    openLink(context,
                        'https://hr.berkeley.edu/sites/default/files/attachments/Hiring_Process_Checklist.pdf');
                  },
                ),
                FeatureCard(
                  title: 'Reference Check',
                  description:
                      'This template streamlines the reference-checking process, enabling a comprehensive evaluation of a candidate\'s professional background.',
                  imagePath: 'assets/images/reference-check.png',
                  onTap: () {
                    openLink(context,
                        'https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=&ved=2ahUKEwjorpeDudKDAxWhywIHHUp7BL4QFnoECBMQAQ&url=https%3A%2F%2Fwww.fairwork.gov.au%2Fsites%2Fdefault%2Ffiles%2Fmigration%2F766%2FReference-checking-form.docx&usg=AOvVaw1TA-0PyC8aY6Xu3AozapNu&opi=89978449');
                  },
                ),
                const SizedBox(height: 25),
                const SectionTitle(title: 'Related Articles'),
                const SizedBox(height: 10),
                FutureBuilder<List<dynamic>>(
                  future: fetchArticles('startup marketing'),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Align(
                        child: CircularProgressIndicator(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                        ),
                      ); // Show loading indicator
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      final List<dynamic> articles = snapshot.requireData;
                      double screenHeight = MediaQuery.of(context).size.height;
                      double customHeight = screenHeight - 500;
                      return SizedBox(
                        height: customHeight,
                        child: ListView.builder(
                          shrinkWrap: true, // Add this line
                          itemCount: articles.length,
                          itemBuilder: (context, index) {
                            final article = articles[index];
                            return FeatureCard(
                                title: article['title'],
                                description: article['description'],
                                url: article['urlToImage'],
                                external: true,
                                onTap: () {
                                  openLink(
                                    context,
                                    'www.udemy.com${article['url']}',
                                  );
                                });
                          },
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
