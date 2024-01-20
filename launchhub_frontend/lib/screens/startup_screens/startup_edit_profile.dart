import 'package:flutter/material.dart';
import 'package:launchhub_frontend/widgets/profiles_shared/bottom_bar.dart';

class StartupEditProfile extends StatefulWidget {
  const StartupEditProfile({super.key});

  @override
  State<StartupEditProfile> createState() => _StartupEditProfileState();
}

class _StartupEditProfileState extends State<StartupEditProfile> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(37), topRight: Radius.circular(37)),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 0, 0, 0),
                offset: Offset(0, -0.01),
                blurRadius: 6.00,
                spreadRadius: 0.00,
              ),
            ],
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: const Text(
              'Edit Profile',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 20,
                color: Color.fromARGB(255, 0, 0, 0),
                fontWeight: FontWeight.w600,
              ),
            ),
            centerTitle: true,
          ),
          body: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage('assets/images/profile.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const Column(
                    children: [
                      Text(
                        'Startup Name',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 20,
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Startup',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 15,
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'About',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 20,
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
