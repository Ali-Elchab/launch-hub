import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:launchhub_frontend/config/base_dio.dart';
import 'package:launchhub_frontend/data/api_constants.dart';
import 'package:launchhub_frontend/models/industry.dart';
import 'package:launchhub_frontend/models/job_seeker.dart';
import 'package:launchhub_frontend/models/niche.dart';
import 'package:launchhub_frontend/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

final dio = Dio();

final jobSeekerProfileProvider =
    ChangeNotifierProvider<JobSeekerProfileProvider>((ref) {
  return JobSeekerProfileProvider(
      user: User(
        id: 0,
        email: '',
        typeId: 0,
      ),
      jobSeeker: JobSeeker(
        id: 0,
        firstName: '',
        lastName: '',
        phone: '',
        address: '',
        bio: '',
        dob: '',
        isAvailable: 0,
        profilePic: '',
        resume: '',
        specializationId: 0,
        industryId: 0,
        userId: 0,
      ));
});

class JobSeekerProfileProvider with ChangeNotifier {
  JobSeekerProfileProvider({required this.user, required this.jobSeeker});
  User user;
  JobSeeker jobSeeker;
  void loadUser(User user) {
    user = user;
    notifyListeners();
  }

  void loadJobSeeker(JobSeeker jobSeeker) {
    jobSeeker = jobSeeker;
    notifyListeners();
  }
}
