import 'package:flutter/material.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/bottom_bar.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/feature_card.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/header.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(180),
        child: Header(
          title: 'Vast',
          showBackButton: false,
        ),
      ),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Center(
          child: SizedBox(
            width: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 25),
                Column(
                  children: [
                    FeatureCard(
                      title: 'Job Board',
                      description:
                          'Empower Your Team\'s Growth: Effortlessly Add, View, and Manage Job Listings to Connect with Top Talent and Shape Your Company\'s Future.',
                      imagePath: 'assets/images/job_board.png',
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
