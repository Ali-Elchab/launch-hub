import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:launchhub_frontend/helpers/open_link.dart';
import 'package:launchhub_frontend/providers/data_provider.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/feature_card.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/header.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/section_title.dart';

class ArticlesAndTemplates extends StatelessWidget {
  const ArticlesAndTemplates(
      {super.key,
      required this.templates,
      required this.query,
      required this.text,
      required this.title});

  final String query;
  final List<dynamic> templates;
  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(180),
        child: Header(
          text: text,
          title: title,
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
                ...templates.map((template) {
                  return FeatureCard(
                    title: template['title'],
                    description: template['description'],
                    imagePath: template['imagePath'],
                    onTap: () {
                      downloadFile(
                        context: context,
                        url: template['url'],
                        name: template['title'],
                      );
                    },
                  );
                }),
                const SizedBox(height: 25),
                const SectionTitle(title: 'Related Articles'),
                const SizedBox(height: 10),
                Consumer(
                  builder: (context, ref, child) =>
                      FutureBuilder<List<dynamic>>(
                    future: ref.read(dataProvider).fetchArticles(query),
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
                        double screenHeight =
                            MediaQuery.of(context).size.height;
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
                                      article['url'],
                                    );
                                  });
                            },
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
