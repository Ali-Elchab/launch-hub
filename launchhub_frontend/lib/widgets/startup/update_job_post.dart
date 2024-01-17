import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:launchhub_frontend/data/static_data.dart';
import 'package:launchhub_frontend/helpers/select_date.dart';
import 'package:launchhub_frontend/helpers/show_modal_sheet.dart';
import 'package:launchhub_frontend/models/industry.dart';
import 'package:launchhub_frontend/models/job_post.dart';
import 'package:launchhub_frontend/models/niche.dart';
import 'package:launchhub_frontend/models/skill.dart';
import 'package:launchhub_frontend/providers/data_provider.dart';
import 'package:launchhub_frontend/providers/job_board_provider.dart';
import 'package:launchhub_frontend/widgets/generic_drop_down.dart';
import 'package:launchhub_frontend/widgets/input_field.dart';
import 'package:launchhub_frontend/widgets/location_picker.dart';
import 'package:launchhub_frontend/widgets/startup/pick_skills.dart';
import 'package:launchhub_frontend/widgets/submit_button.dart';
import 'package:intl/intl.dart';

class UpdateJobPost extends ConsumerStatefulWidget {
  const UpdateJobPost({super.key, this.postJob, this.jobPost});

  final Function? postJob;
  final JobPost? jobPost;

  @override
  ConsumerState<UpdateJobPost> createState() {
    return _UpdateJobPostState();
  }
}

class _UpdateJobPostState extends ConsumerState<UpdateJobPost> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime? _selectedDate;
  Industry? _selectedIndustry;
  Niche? _selectedNiche;
  String? _selectExperienceLevel;
  String? _selectEducationceLevel;
  String? _selectJobType;
  String? _selectGender;
  String? _selectJobStatus;
  List selectedSkills = [];
  final _formKey = GlobalKey<FormState>();
  final _responsibilitiesController = TextEditingController();
  final _jobSalaryController = TextEditingController();
  final _jobQualificationController = TextEditingController();
  final _jobDeadlineController = TextEditingController();
  @override
  void initState() {
    super.initState();
    if (widget.jobPost != null) {
      final industry = ref.read(dataProvider).industries.firstWhere(
          (element) => element.id == widget.jobPost!.industryId,
          orElse: () => Industry(id: 1, name: ' name'));

      final specialization = ref
          .read(dataProvider)
          .niches
          .where((element) => element.id == widget.jobPost!.specializationId)
          .first;

      _titleController.text = widget.jobPost!.jobTitle;
      _descriptionController.text = widget.jobPost!.jobDescription;
      _responsibilitiesController.text = widget.jobPost!.responsibilities;
      _jobSalaryController.text = widget.jobPost!.jobSalary.toString();
      _jobQualificationController.text = widget.jobPost!.jobQualification;
      _jobDeadlineController.text = widget.jobPost!.deadline;
      _selectedIndustry = industry;
      _selectedNiche = specialization;
      _selectExperienceLevel = widget.jobPost!.experienceLevel;
      _selectEducationceLevel = widget.jobPost!.educationLevel;
      _selectJobType = widget.jobPost!.jobType;
      _selectGender = widget.jobPost!.preferredGender;
      selectedSkills = widget.jobPost!.requiredSkills;
      _selectJobStatus = widget.jobPost!.jobStatus;
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    _selectedDate = await selectDate(context, _selectedDate);
    if (_selectedDate != null) {
      setState(() {
        _jobDeadlineController.text =
            DateFormat('yyyy-MM-dd').format(_selectedDate!);
      });
    }
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Invalid input'),
        content: const Text('Please make sure you filled all entries.'),
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
        _jobQualificationController.text.trim().isEmpty ||
        _jobDeadlineController.text.trim().isEmpty ||
        _jobSalaryController.text.trim().isEmpty ||
        _jobQualificationController.text.trim().isEmpty ||
        _jobDeadlineController.text.trim().isEmpty ||
        _jobSalaryController.text.trim().isEmpty) {
      _showDialog();
      return;
    }

    ref.read(jobBoardProvider).updateJobPost({
      "id": widget.jobPost!.id,
      "deadline": _jobDeadlineController.text,
      "education_level": _selectEducationceLevel!,
      "experience_level": _selectExperienceLevel!,
      "job_description": _descriptionController.text,
      "job_title": _titleController.text,
      "job_type": _selectJobType!,
      "responsibilities": _responsibilitiesController.text,
      "industry_id": _selectedIndustry!.id,
      "job_location": ref.read(jobBoardProvider).address,
      "job_salary": int.parse(_jobSalaryController.text),
      "job_qualification": _jobQualificationController.text,
      "preferred_gender": _selectGender!,
      "specialization_id": _selectedNiche!.id,
      "required_skills": selectedSkills,
      "job_status": _selectJobStatus,
    });
    Navigator.pop(context);
  }

  // @override
  // void dispose() {
  //   _titleController.dispose();
  //   _descriptionController.dispose();
  //   super.dispose();
  // }

  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field cannot be empty';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(jobBoardProvider);

    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        child: Column(
          children: [
            Container(
              height: 200,
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
                            Text('Update Job Post',
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
                          'Update your job post to attract the best talent.',
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
                      GenericDropdown(
                        label: 'Job Status',
                        options: const ['open', 'closed'],
                        selectedOption: _selectJobStatus,
                        optionLabel: (option) => option.toString(),
                        onChanged: (newValue) {
                          setState(() {
                            _selectJobStatus = newValue;
                          });
                        },
                      ),
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
                        country: provider.country,
                        state: provider.state,
                      ),
                      InputField(
                        label: 'Salary / Month',
                        controller: _jobSalaryController,
                        keyboardType: TextInputType.number,
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
                        options: ref.watch(dataProvider).industries,
                        selectedOption: _selectedIndustry,
                        optionLabel: (industry) => industry!.name,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedIndustry = newValue;
                            _selectedNiche = null;
                          });
                          ref
                              .read(dataProvider.notifier)
                              .getNiches(_selectedIndustry!);
                        },
                      ),
                      GenericDropdown<Niche>(
                        label: 'Select Specialization',
                        options: ref.watch(dataProvider).niches,
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
