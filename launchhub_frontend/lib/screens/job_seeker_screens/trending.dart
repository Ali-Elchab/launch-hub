import 'package:flutter/material.dart';
import 'package:launchhub_frontend/data/articles_api.dart';
import 'package:launchhub_frontend/helpers/open_link.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/bottom_bar.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/feature_card.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/header.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/section_title.dart';

class Trending extends StatelessWidget {
  const Trending({super.key, required this.specialization});

  final String specialization;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(180),
        child: Header(
          text:
              'Navigate your career journey with our Articles and Guides page, a rich resource for job seekers. Explore essential insights covering interviews, resumes, and beyond, empowering you with expert guidance for success in your professional endeavors.',
          title: 'Trending',
        ),
      ),
      body: Center(
        child: SizedBox(
          width: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 45),
              const SectionTitle(title: 'Trending Articles'),
              FutureBuilder<List<dynamic>>(
                future: fetchArticles('job seeker $specialization'),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Align(
                      child: CircularProgressIndicator(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                      ),
                    ); // Show loading indicator
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    final List<dynamic> articles = snapshot.requireData;
                    double screenHeight = MediaQuery.of(context).size.height;
                    double customHeight = screenHeight - 59;
                    return Expanded(
                      child: SizedBox(
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
                                  openLink(context, article['url']);
                                });
                          },
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
