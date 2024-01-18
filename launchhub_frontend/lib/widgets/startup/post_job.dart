import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:launchhub_frontend/data/static_data.dart';
import 'package:launchhub_frontend/helpers/select_date.dart';
import 'package:launchhub_frontend/helpers/show_modal_sheet.dart';
import 'package:launchhub_frontend/models/industry.dart';
import 'package:launchhub_frontend/models/job_post.dart';
import 'package:launchhub_frontend/models/niche.dart';
import 'package:launchhub_frontend/providers/data_provider.dart';
import 'package:launchhub_frontend/providers/job_board_provider.dart';
import 'package:launchhub_frontend/providers/startup_profile_provider.dart';
import 'package:launchhub_frontend/widgets/generic_drop_down.dart';
import 'package:launchhub_frontend/widgets/input_field.dart';
import 'package:launchhub_frontend/widgets/location_picker.dart';
import 'package:launchhub_frontend/widgets/startup/pick_skills.dart';
import 'package:launchhub_frontend/widgets/submit_button.dart';
import 'package:intl/intl.dart';

class PostJob extends ConsumerStatefulWidget {
  const PostJob({super.key});

  @override
  ConsumerState<PostJob> createState() {
    return _PostJobState();
  }
}

class _PostJobState extends ConsumerState<PostJob> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime? _selectedDate;
  Industry? _selectedIndustry;
  Niche? _selectedNiche;
  String? _selectExperienceLevel;
  String? _selectEducationceLevel;
  String? _selectJobType;
  String? _selectGender;
  List selectedSkills = [];
  final _formKey = GlobalKey<FormState>();
  final _responsibilitiesController = TextEditingController();
  final _jobSalaryController = TextEditingController();
  final _jobQualificationController = TextEditingController();
  final _jobDeadlineController = TextEditingController();
  @override
  void initState() {
    super.initState();
    ref.read(dataProvider).getIndustries();
  }

  Future getNiches() async {
    await ref.read(dataProvider).getNiches(_selectedIndustry);
  }

  Future<void> _selectDate(BuildContext context) async {
    final picked = await selectDate(context, _selectedDate);
    setState(() {
      _selectedDate = picked;
      _jobDeadlineController.text = DateFormat('yyyy-MM-dd').format(picked);
    });
  }

  void _showDialog(text) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Invalid input'),
        content: Text(text),
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
    final enteredSalary = double.tryParse(_jobSalaryController.text);
    final salaryIsInvalid = enteredSalary == null || enteredSalary <= 0;
    if (_titleController.text.trim().isEmpty ||
        _descriptionController.text.trim().isEmpty ||
        salaryIsInvalid ||
        _selectedIndustry == null ||
        _selectedNiche == null ||
        _selectExperienceLevel == null ||
        _selectEducationceLevel == null ||
        _selectJobType == null ||
        _selectGender == null ||
        selectedSkills.isEmpty ||
        _jobSalaryController.text.trim().isEmpty ||
        _jobQualificationController.text.trim().isEmpty ||
        _jobDeadlineController.text.trim().isEmpty ||
        _jobSalaryController.text.trim().isEmpty) {
      if (salaryIsInvalid) {
        _jobSalaryController.text = '';
        _showDialog('Please make sure you fill only numbers in salary field.');
      }
      if (selectedSkills.isEmpty) {
        _showDialog('Please select at least one skill.');
      }
      _showDialog('Please fill all the fields.');
      return;
    }

    ref.read(jobBoardProvider).postJob(JobPost(
          id: ref.read(jobBoardProvider).jobPosts.length + 1,
          jobTitle: _titleController.text,
          jobDescription: _descriptionController.text,
          jobLocation: ref.read(jobBoardProvider).address!,
          jobType: _selectJobType!,
          jobSalary: int.parse(_jobSalaryController.text),
          jobQualification: _jobQualificationController.text,
          responsibilities: _responsibilitiesController.text,
          experienceLevel: _selectExperienceLevel!,
          educationLevel: _selectEducationceLevel!,
          preferredGender: _selectGender!,
          deadline: _jobDeadlineController.text,
          requiredSkills: selectedSkills.map((skill) => skill['id']).toList(),
          jobStatus: 'open',
          industryId: _selectedIndustry!.id,
          specializationId: _selectedNiche!.id,
          startupId: ref.read(startupProfileProvider).startup.id,
        ));
    Navigator.pop(context);
  }

  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field cannot be empty';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final jobboardprovider = ref.watch(jobBoardProvider);
    final industries = ref.watch(dataProvider).industries;
    final niches = ref.watch(dataProvider).niches;
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
                child: Form(
                  key: _formKey,
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
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: Colors.white,
                                  ),
                        ),
                      ),
                    ],
                  ),
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
                        label: 'Qualification',
                        isDescription: true,
                        controller: _jobQualificationController,
                      ),
                      InputField(
                        label: 'Responsibilities',
                        isDescription: true,
                        controller: _responsibilitiesController,
                      ),
                      GenericDropdown<String>(
                        label: 'Select Experience Level',
                        options: experienceLevels,
                        selectedOption: _selectExperienceLevel,
                        optionLabel: (option) => option.toString(),
                        onChanged: (newValue) {
                          setState(() {
                            _selectExperienceLevel = newValue;
                          });
                        },
                      ),
                      GenericDropdown<String>(
                        label: 'Select Education Level',
                        options: educationLevels,
                        selectedOption: _selectEducationceLevel,
                        optionLabel: (option) => option.toString(),
                        onChanged: (newValue) {
                          setState(() {
                            _selectEducationceLevel = newValue;
                          });
                        },
                      ),
                      InputField(
                        label: 'Required Skills',
                        readOnly: true,
                        onTap: () {
                          showModal(PickSkills(selectedSkills: selectedSkills),
                              context);
                        },
                        isDescription: true,
                        controller: TextEditingController(
                            text: selectedSkills
                                .map((skill) => skill['name'])
                                .join(', ')),
                        icon: const Icon(Icons.add_circle_outline),
                      ),
                      GenericDropdown<String>(
                        label: 'Select Job Type',
                        options: jobTypes,
                        selectedOption: _selectJobType,
                        optionLabel: (option) => option.toString(),
                        onChanged: (newValue) {
                          setState(() {
                            _selectJobType = newValue;
                          });
                        },
                      ),
                      LocationPicker(
                        onCountryChanged: ref.read(jobBoardProvider).setCountry,
                        onStateChanged:
                            ref.read(jobBoardProvider).setStateForState,
                        country: jobboardprovider.country,
                        state: jobboardprovider.state,
                      ),
                      InputField(
                        label: 'Salary / Month',
                        controller: _jobSalaryController,
                      ),
                      GenericDropdown<String>(
                        label: 'Select Preffered Gender',
                        options: genders,
                        selectedOption: _selectGender,
                        optionLabel: (option) => option.toString(),
                        onChanged: (newValue) {
                          setState(() {
                            _selectGender = newValue;
                          });
                        },
                      ),
                      GenericDropdown<Industry>(
                        label: 'Select Industry',
                        options: industries,
                        selectedOption: _selectedIndustry,
                        optionLabel: (industry) => industry!.name,
                        onChanged: (newValue) async {
                          setState(() {
                            _selectedIndustry = newValue;
                            _selectedNiche = null;
                          });
                          await getNiches();
                        },
                      ),
                      GenericDropdown<Niche>(
                        label: 'Select Specialization',
                        options: niches,
                        selectedOption: _selectedNiche,
                        optionLabel: (niche) => niche!.name,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedNiche = newValue;
                          });
                        },
                      ),
                      InputField(
                        label: 'Deadline',
                        readOnly: true,
                        validator: validator,
                        onTap: () => _selectDate(context),
                        controller: _jobDeadlineController,
                        icon: const Icon(Icons.calendar_today),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: 300, child: SubmitButton('Submit', _submitJobData)),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
