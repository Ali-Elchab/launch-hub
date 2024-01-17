// import 'package:launchhub_frontend/data/server_requests.dart';
import 'package:flutter/material.dart';
import 'package:launchhub_frontend/data/mock_data.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/bottom_bar.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/header.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/search_filter.dart';
import 'package:launchhub_frontend/widgets/startup/advisor_card.dart';

class Advisors extends StatelessWidget {
  const Advisors(
      {super.key,
      required this.title,
      required this.text,
      required this.category});

  final String title;
  final String text;
  final String category;

  @override
  Widget build(BuildContext context) {
    Widget mainContent = Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.clear_rounded,
            size: 80,
            color: Color.fromARGB(255, 0, 0, 0),
          ),
          const SizedBox(height: 30),
          Text('No Advisors found',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
              textAlign: TextAlign.center),
        ],
      ),
    );

    if (dummyJobSeekers.isNotEmpty) {
      final advisors = dummyAdvisors
          .where((advisor) => advisor.category.toLowerCase() == category)
          .toList();
      mainContent = ListView.builder(
        itemCount: advisors.length,
        itemBuilder: (context, index) => Column(
          children: [
            AdvisorCard(
              advisor: advisors[index],
            ),
            const SizedBox(height: 20),
          ],
        ),
      );
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(180),
        child: Header(
          title: title,
          text: text,
        ),
      ),
      body: Center(
        child: SizedBox(
          width: 300,
          child: Column(
            children: [
              const SizedBox(height: 25),
              SearchFilter(
                onPressedFilter: () {},
                margin: 10,
              ),
              Expanded(
                child: mainContent,
              ),
              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
