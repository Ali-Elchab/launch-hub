import 'package:flutter/material.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/bottom_bar.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/header.dart';

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
            width: 280,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 25),
                Column(
                  children: [
                    for (var i = 0; i < 3; i++)
                      const Text(
                        ' Welcome to Vast, your premier app for turning visions into reality. We are a community of entrepreneurs, investors, and mentors who are here to help you launch your startup. We provide a platform for you to connect with other entrepreneurs, investors, and mentors to help you launch your startup. We also provide a platform for you to connect with other entrepreneurs, investors, and mentors to help you launch your startup. We also provide a platform for you to connect with other entrepreneurs, investors, and mentors to help you launch your startup. We also provide a platform for you to connect with other entrepreneurs, investors, and mentors to help you launch your startup. We also provide a platform for you to connect with other entrepreneurs, investors, and mentors to help you launch your startup. We also provide a platform for you to connect with other entrepreneurs, investors, and mentors to help you launch your startup',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
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
