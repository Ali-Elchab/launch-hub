import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:launchhub_frontend/helpers/navigator.dart';
import 'package:launchhub_frontend/models/startup.dart';
import 'package:launchhub_frontend/providers/startup_profile_provider.dart';
import 'package:launchhub_frontend/providers/startup_register_provider.dart';
import 'package:launchhub_frontend/widgets/auth_widgets/bottom_text.dart';
import 'package:launchhub_frontend/widgets/auth_widgets/profile_pic_input.dart';
import 'package:launchhub_frontend/widgets/custom_appbar.dart';
import 'package:launchhub_frontend/widgets/input_field.dart';
import 'package:launchhub_frontend/widgets/small_button.dart';

class Founders extends ConsumerWidget {
  Founders({super.key});

  final founderController = TextEditingController();
  final ceoController = TextEditingController();
  final keyexecutiveController = TextEditingController();

  // List<String> founders = [];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field cannot be empty';
    }
    return null;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final provider = ref.watch(startupRegisterProvider);
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: const CustomAppBar(title: 'Startup Profile'),
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.only(top: 75),
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/backgrounds/auth_bg.png'),
              fit: BoxFit.cover),
        ),
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.73,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Founders & Key Members',
                    style: textTheme.titleLarge,
                  ),
                  const SizedBox(height: 35),
                  if (provider.selectedImage != null)
                    Align(
                      alignment: Alignment.center,
                      child: ClipOval(
                        child: Image.file(
                          File(provider.selectedImage!.path),
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  if (provider.selectedImage == null)
                    Align(
                      alignment: Alignment.center,
                      child: ProfileImagePicker(
                          onImagePicked: () async {
                            await ref
                                .read(startupRegisterProvider.notifier)
                                .pickImage();
                          },
                          imageFile: provider.selectedImage,
                          text: 'Upload Logo'),
                    ),
                  const SizedBox(height: 32),
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                    Expanded(
                      child: InputField(
                        label: 'Add Founder',
                        controller: founderController,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        ref
                            .read(startupRegisterProvider.notifier)
                            .addNewFounder(
                              founderController.text,
                            );
                        founderController.clear();
                      },
                      icon: const Icon(Icons.add),
                    )
                  ]),
                  SizedBox(
                    height: 40,
                    width: MediaQuery.of(context).size.width * 0.61,
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: provider.founders.length,
                      itemBuilder: (context, index) {
                        return Dismissible(
                          background: Container(
                            color: const Color.fromARGB(255, 167, 11, 0),
                            alignment: Alignment.centerRight,
                            margin: const EdgeInsets.symmetric(
                              vertical: 5,
                            ),
                            child: const Icon(
                              Icons.delete,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          key: ValueKey(provider.founders[index]),
                          onDismissed: (direction) {
                            ref
                                .read(startupRegisterProvider.notifier)
                                .removeFounder(provider.founders[index]);
                          },
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            margin: const EdgeInsets.only(bottom: 6),
                            decoration: const BoxDecoration(
                              color: Color(0xFFF5F5F5),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Text(
                              provider.founders[index],
                              style: textTheme.bodyLarge,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                    Expanded(
                      child: InputField(
                        label: 'Add CEO',
                        controller: ceoController,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        ref.read(startupRegisterProvider.notifier).addNewCEO(
                              ceoController.text,
                            );
                        ceoController.clear();
                      },
                      icon: const Icon(Icons.add),
                    )
                  ]),
                  SizedBox(
                    height: 40,
                    width: MediaQuery.of(context).size.width * 0.61,
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: provider.ceos.length,
                      itemBuilder: (context, index) {
                        return Dismissible(
                          background: Container(
                            color: const Color.fromARGB(255, 167, 11, 0),
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 20),
                            margin: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 4,
                            ),
                            child: const Icon(
                              Icons.delete,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                          key: ValueKey(provider.ceos[index]),
                          onDismissed: (direction) {
                            ref
                                .read(startupRegisterProvider.notifier)
                                .removeCEO(provider.ceos[index]);
                          },
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            margin: const EdgeInsets.only(bottom: 16),
                            decoration: const BoxDecoration(
                              color: Color(0xFFF5F5F5),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Text(
                              provider.ceos[index],
                              style: textTheme.bodyLarge,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                    Expanded(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: InputField(
                          label: 'Add Key Executive',
                          controller: keyexecutiveController,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        ref
                            .read(startupRegisterProvider.notifier)
                            .addNewKeyExecutive(
                              keyexecutiveController.text,
                            );
                        keyexecutiveController.clear();
                      },
                      icon: const Icon(Icons.add),
                    )
                  ]),
                  SizedBox(
                    height: 40,
                    width: MediaQuery.of(context).size.width * 0.61,
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: provider.keyExecutives.length,
                      itemBuilder: (context, index) {
                        return Dismissible(
                          background: Container(
                            color: const Color.fromARGB(255, 167, 11, 0),
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 20),
                            margin: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 4,
                            ),
                            child: const Icon(
                              Icons.delete,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                          key: ValueKey(provider.ceos[index]),
                          onDismissed: (direction) {
                            ref
                                .read(startupRegisterProvider.notifier)
                                .removeKeyExecutive(provider.ceos[index]);
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            margin: const EdgeInsets.only(bottom: 16),
                            decoration: const BoxDecoration(
                              color: Color(0xFFF5F5F5),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: Text(
                              provider.keyExecutives[index],
                              style: textTheme.bodyLarge,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  // const Spacer(),
                  Align(
                    alignment: Alignment.center,
                    child: SmallButton('Submit', () async {
                      if (provider.founders.isNotEmpty) {
                        final response = await ref
                            .read(startupRegisterProvider.notifier)
                            .registerStartup();
                        if (provider.isRegistered) {
                          final jsonStartup = await response['user'];
                          final startup = Startup.fromJson(jsonStartup);
                          ref.read(startupProfileProvider).loadStartup(startup);
                          navigatorKey.currentState?.pushNamedAndRemoveUntil(
                              '/StartupRoot', (Route<dynamic> route) => false);
                        } else {
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Error: ${provider.errorMessage}'),
                            ),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Please add at least one founder')),
                        );
                      }
                    }, showArrow: false),
                  ),
                  const SizedBox(height: 15),
                  const BottomText(
                    text:
                        'This information will be showcased to job seekers, helping them make informed decisions about opportunities with your company.',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
