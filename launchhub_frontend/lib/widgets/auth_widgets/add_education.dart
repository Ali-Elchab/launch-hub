import 'package:flutter/material.dart';
import 'package:launchhub_frontend/data/mock_data.dart';
import 'package:launchhub_frontend/models/education.dart';
import 'package:launchhub_frontend/models/industry.dart';
import 'package:launchhub_frontend/models/niche.dart';
import 'package:launchhub_frontend/models/skill.dart';
import 'package:launchhub_frontend/widgets/generic_drop_down.dart';
import 'package:launchhub_frontend/widgets/input_field.dart';
import 'package:launchhub_frontend/widgets/submit_button.dart';
import 'package:intl/intl.dart';

class AddEducation extends StatefulWidget {
  const AddEducation({
    super.key,
    required this.addEducation,
  });

  final void Function(Education education) addEducation;

  @override
  State<AddEducation> createState() {
    return _AddEducationState();
  }
}

class _AddEducationState extends State<AddEducation> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime? _selectedDate;
  Industry? _selectedIndustry;
  Niche? _selectedNiche;
  String? _selectExperienceLevel;
  String? _selectEducationceLevel;
  String? _selectJobType;
  String? _selectGender;
  String? _selectLocation;
  List<Skill> selectedSkills = [];
  final _formKey = GlobalKey<FormState>();
  final _responsibilitiesController = TextEditingController();
  final _jobSalaryController = TextEditingController();
  final _jobQualificationController = TextEditingController();
  final _jobDeadlineController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _jobDeadlineController.text = DateFormat('yyyy-MM-dd')
            .format(picked); // Format date as 'yyyy-MM-dd'
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
        _selectLocation == null ||
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

    // widget.addEducation(
    //   Education(
    //     id: '1',
    //    degree: _degreeController.text,
    //     organization: _organizationController.text,
    //     startDate: _startDateController.text,
    //     endDate: _endDateController.text,
    //     description: _descriptionController.text,
    //     location: _locationController.text,
    //     jobSeekerId:2 ,

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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 58, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 90,
                height: 5,
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Text(
                'Add Education',
                style: Theme.of(context).textTheme.titleLarge,
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
                          onTap: () {},
                          isDescription: true,
                          controller: TextEditingController(
                              text: selectedSkills.join(', ')),
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
                        GenericDropdown<String>(
                          label: 'Select Location',
                          options: locations,
                          selectedOption: _selectLocation,
                          optionLabel: (option) => option.toString(),
                          onChanged: (newValue) {
                            setState(() {
                              _selectLocation = newValue;
                            });
                          },
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
                          onChanged: (newValue) {
                            setState(() {
                              _selectedIndustry = newValue;
                            });
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
              SizedBox(
                  width: 300, child: SubmitButton('Submit', _submitJobData)),
              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
