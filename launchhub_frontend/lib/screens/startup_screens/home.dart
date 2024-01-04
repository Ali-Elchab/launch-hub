import 'package:flutter/material.dart';
import 'package:launchhub_frontend/widgets/auth_widgets/custom_appbar.dart';

class Home extends StatefulWidget {
  final String title;
  const Home({super.key, this.title});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(180),
        child: Container(
          height: 180, // Specify the height to match PreferredSize
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(37),
              bottomRight: Radius.circular(37),
            ),
            image: DecorationImage(
              image: AssetImage('assets/backgrounds/header.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Use minimal space for the Column
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CustomAppBar(
                  title: 'Vast',
                  textColor: Colors.white,
                  showBackButton: false),
              Expanded(
                child: SizedBox(
                  width: 280,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    physics: const ClampingScrollPhysics(),
                    child: Text(
                      textAlign: TextAlign.left,
                      'Your Premier App for Turning Visions into Reality ',
                      style:
                          Theme.of(context).textTheme.headlineSmall!.copyWith(
                                color: Colors.white,
                                fontSize: 22,
                              ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: const Center(
        child: Text('Home'),
      ),
    );
  }
}
