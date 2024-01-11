import 'package:flutter/material.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/bottom_bar.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/header.dart';

class JobBoard extends StatefulWidget {
  const JobBoard({super.key});

  @override
  State<JobBoard> createState() => _JobBoardState();
}

class _JobBoardState extends State<JobBoard> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(180),
        child: Header(
          title: 'Job Board',
          text:
              'Cultivate your team and shape your company\'s future. Here in the Job board, effortlessly add, view, and manage your job listings, empowering you to connect with top talent seamlessly.',
        ),
      ),
      body: Center(
        child: SizedBox(
          width: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 45),
              Column(
                children: [],
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
