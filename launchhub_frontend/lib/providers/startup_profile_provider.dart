import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:launchhub_frontend/models/user.dart';

final startupProfileProvider = StateProvider<StartupProfileProvider>((ref) {
  return StartupProfileProvider(email: '', type: 0, id: 0);
});

class StartupProfileProvider with ChangeNotifier {
  String email;
  int type;
  int id;

  StartupProfileProvider(
      {required this.email, required this.type, required this.id});

  void loadProfile(User user) {
    email = user.email;
    type = user.typeId;
    id = user.id;

    notifyListeners();
  }
}
