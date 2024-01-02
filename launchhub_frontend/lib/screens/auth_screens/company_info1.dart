import 'package:flutter/material.dart';
import 'package:launchhub_frontend/screens/auth_screens/signin.dart';
import 'package:launchhub_frontend/widgets/custom_appbar.dart';
import 'package:launchhub_frontend/widgets/input_field.dart';
import 'package:launchhub_frontend/widgets/submit_button.dart';

class CompanyInfo1 extends StatelessWidget {
  const CompanyInfo1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const CustomAppBar(title: 'Startup Profile'),
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          width: 280,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,

            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    'Company Information',
                    textAlign: TextAlign.left,
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(fontWeight: FontWeight.w700, fontSize: 22),
                  ),
                ),
              ),
              const SizedBox(height: 35),
              const HeaderSection(),
              const SizedBox(height: 16),
              const InputField(label: 'Email'),
              const SizedBox(height: 16),
              const InputField(label: 'Email'),
              const SizedBox(height: 16),
              const InputField(label: 'Email'),
              const SizedBox(height: 16),
              const InputField(label: 'Email'),
              const SizedBox(height: 16),
              const InputField(label: 'Email'),
              const SizedBox(height: 16),
              const InputField(label: 'Email'),
              const SizedBox(height: 16),
              SubmitButton('Sign In', () {}),
            ],
          ),
        ),
      ),
    );
  }
}
