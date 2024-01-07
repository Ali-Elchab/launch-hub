import 'dart:io';

import 'package:flutter/material.dart';
import 'package:launchhub_frontend/data/mockData.dart';
import 'package:launchhub_frontend/models/industry.dart';
import 'package:launchhub_frontend/models/jobPost.dart';
import 'package:launchhub_frontend/widgets/auth_widgets/date_picker.dart';
import 'package:launchhub_frontend/widgets/auth_widgets/industry_drop_down.dart';
import 'package:launchhub_frontend/widgets/input_field.dart';
import 'package:launchhub_frontend/widgets/submit_button.dart';
import 'package:intl/intl.dart';

class PostJob extends StatefulWidget {
  const PostJob({super.key, required this.postJob});

  final void Function(JobPost jobPost) postJob;

  @override
  State<PostJob> createState() {
    return _PostJobState();
  }
}

class _PostJobState extends State<PostJob> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime? _selectedDate;
  Industry? _selectedIndustry;
  final _formKey = GlobalKey<FormState>();
  final _responsibilitiesController = TextEditingController();
  final _requirementsController = TextEditingController();
  final _skillsController = TextEditingController();
  final _jobTypeController = TextEditingController();
  final _jobLocationController = TextEditingController();
  final _jobSalaryController = TextEditingController();
  final _preferredGenderController = TextEditingController();
  final _experienceLevelController = TextEditingController();
  final _educationalLevelController = TextEditingController();
  final _jobStatusController = TextEditingController();
  final _jobQualificationController = TextEditingController();
  final _jobSpecializationController = TextEditingController();
  final _jobIndustryController = TextEditingController();
  final _jobDeadlineController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _jobDeadlineController.text =
            DateFormat('yyyy-MM-dd').format(picked); // Format date as required
      });
    }
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Invalid input'),
        content: const Text(
            'Please make sure a valid title, amount, date and category was entered.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
            },
            child: const Text('Okay'),
          ),
        ],
      ),
    );
  }

  void _submitJobData() {
    // final enteredAmount = double.tryParse(_descri.text);
    // final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        _descriptionController.text.trim().isEmpty ||
        _selectedDate == null) {
      _showDialog();
      return;
    }

    // widget.postJob(
    //   JobPost(
    //     deadline: _selectedDate.toString(),
    //     educationLevel: String,
    //     experienceLevel: String,
    //     jobDescription: String,
    //     jobTitle: String,
    //     jobType: String,
    //     industryId: int,
    //     jobLocation: String,
    //     jobSalary: int,
    //     jobQualification: String,
    //     jobStatus: amountIsInvalid,
    //     preferredGender: String,
    //     specializationId: int,
    //   ),
    // );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field cannot be empty';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(0, 30, 0, 16),
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/backgrounds/header.png'),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(37),
                  bottomRight: Radius.circular(37),
                ),
              ),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      width: 300,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Post a Job',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(
                                    color: Colors.white,
                                  )),
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 300,
                      child: Text(
                        textAlign: TextAlign.justify,
                        'Ready to grow your team? Post a job for free and reach potential candidates easily.Your company details and logo will be showcased for job seekers to preview in the listing',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Colors.white,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Container(
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                width: 300,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InputField(
                        label: 'Job Title',
                        controller: _titleController,
                      ),
                      InputField(
                        label: 'Description',
                        isDescription: true,
                        controller: _descriptionController,
                      ),
                      InputField(
                        label: 'Location',
                        controller: _jobLocationController,
                      ),
                      InputField(
                        label: 'Qualification',
                        controller: _jobQualificationController,
                      ),
                      InputField(
                        label: 'Experience Level dropdown',
                        controller: _responsibilitiesController,
                      ),
                      InputField(
                        label: 'Education Level Dropdown',
                        controller: _responsibilitiesController,
                      ),
                      InputField(
                        label: 'Job Type DropDown',
                        controller: _responsibilitiesController,
                      ),
                      InputField(
                        label: 'Salary / Month',
                        controller: _responsibilitiesController,
                      ),
                      InputField(
                        label: 'Preffered Gender Dropdown',
                        controller: _responsibilitiesController,
                      ),
                      InputField(
                        label: 'Required Skills',
                        controller: _responsibilitiesController,
                      ),
                      DatePickerField(
                          controller: _jobDeadlineController,
                          onTap: () => _selectDate(context),
                          validator: validator,
                          text: 'Founding Date'),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: 300, child: SubmitButton('Submit', () {})),
            const SizedBox(height: 25),
          ],
        ),
      ),
      // bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
