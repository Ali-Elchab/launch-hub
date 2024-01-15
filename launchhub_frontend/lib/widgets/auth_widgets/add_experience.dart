import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:launchhub_frontend/data/mock_data.dart';
import 'package:launchhub_frontend/models/experience.dart';
import 'package:launchhub_frontend/models/industry.dart';
import 'package:launchhub_frontend/models/niche.dart';
import 'package:launchhub_frontend/providers/jobseeker_register_provider.dart';
import 'package:launchhub_frontend/widgets/generic_drop_down.dart';
import 'package:launchhub_frontend/widgets/input_field.dart';
import 'package:launchhub_frontend/widgets/location_picker.dart';
import 'package:launchhub_frontend/widgets/submit_button.dart';
import 'package:intl/intl.dart';

class AddExperience extends ConsumerStatefulWidget {
  const AddExperience({
    super.key,
  });

  @override
  ConsumerState<AddExperience> createState() {
    return _AddExperienceState();
  }
}

class _AddExperienceState extends ConsumerState<AddExperience> {
  final _descriptionController = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();
  final _companyController = TextEditingController();
  final _positionController = TextEditingController();
  String? _selectJobType;
  String? country;
  String? state;
  DateTime? _selectedDate;
  Industry? _selectedIndustry;
  Niche? _selectedNiche;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    ref.read(jobSeekerRegisterProvider.notifier).getIndustries();
  }

  Future getNiches(industry) async {
    await ref
        .read(jobSeekerRegisterProvider.notifier)
        .getNiches(industry: industry);
  }

  Future<void> _selectDate(BuildContext context, controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        controller.text = DateFormat('yyyy-MM-dd')
            .format(picked); // Format date as 'yyyy-MM-dd'
      });
    }
  }

  setCountry(String? value) {
    setState(() {
      country = value;
    });
  }

  setStateForState(String? value) {
    setState(() {
      state = value;
    });
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Invalid input'),
        content:
            const Text('Please make sure all required fields are filled out'),
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
    if (_positionController.text.trim().isEmpty ||
        _descriptionController.text.trim().isEmpty ||
        _endDateController.text.trim().isEmpty ||
        _startDateController.text.trim().isEmpty ||
        _companyController.text.trim().isEmpty ||
        country == null) {
      _showDialog();
      return;
    }

    ref.read(jobSeekerRegisterProvider.notifier).addExperience(
          Experience(
            position: _positionController.text,
            company: _companyController.text,
            type: _selectJobType!,
            industry: _selectedIndustry!.id,
            specialization: _selectedNiche!.id,
            startDate: _startDateController.text,
            endDate: _endDateController.text,
            description: _descriptionController.text,
            location: state != null ? '$state, $country' : '$country',
          ),
        );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    _companyController.dispose();
    _selectJobType = null;
    country = null;
    state = null;
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
    final provider = ref.watch(jobSeekerRegisterProvider);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/backgrounds/auth_bg.png'),
              fit: BoxFit.cover),
        ),
        child: Center(
          child: Container(
            width: 300,
            padding: const EdgeInsets.fromLTRB(16, 58, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 90,
                  height: 5,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Add Experience',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                      width: 300,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 16),
                            InputField(
                              label: 'Position',
                              controller: _positionController,
                            ),
                            InputField(
                              label: 'Company',
                              controller: _companyController,
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
                            GenericDropdown<Industry>(
                              label: 'Industry',
                              options: provider.industries,
                              selectedOption: _selectedIndustry,
                              optionLabel: (industry) => industry!.name,
                              onChanged: (newValue) async {
                                setState(() {
                                  _selectedIndustry = newValue!;
                                  _selectedNiche = null;
                                });
                                await getNiches(newValue!);
                              },
                            ),
                            GenericDropdown<Niche>(
                              label: 'Niche',
                              options: provider.niches,
                              selectedOption: _selectedNiche,
                              optionLabel: (niche) => niche!.name,
                              onChanged: (newValue) {
                                setState(() {
                                  _selectedNiche = newValue!;
                                });
                              },
                            ),
                            InputField(
                              label: 'Start Date',
                              readOnly: true,
                              validator: validator,
                              onTap: () =>
                                  _selectDate(context, _startDateController),
                              controller: _startDateController,
                              icon: const Icon(Icons.calendar_today),
                            ),
                            InputField(
                              label: 'End Date',
                              readOnly: true,
                              validator: validator,
                              onTap: () =>
                                  _selectDate(context, _endDateController),
                              controller: _endDateController,
                              icon: const Icon(Icons.calendar_today),
                            ),
                            InputField(
                              label: 'Description',
                              isDescription: true,
                              controller: _descriptionController,
                            ),
                            LocationPicker(
                              onCountryChanged: setCountry,
                              onStateChanged: setStateForState,
                              country: country,
                              state: state,
                            )
                          ],
                        ),
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
      ),
    );
  }
}
