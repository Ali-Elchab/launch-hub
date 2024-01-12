import 'package:flutter/material.dart';
import 'package:launchhub_frontend/models/education.dart';
import 'package:launchhub_frontend/widgets/input_field.dart';
import 'package:launchhub_frontend/widgets/location_picker.dart';
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
  final _descriptionController = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();
  final _organizationController = TextEditingController();
  final _degreeController = TextEditingController();
  String? country;
  String? state;
  DateTime? _selectedDate;
  final _formKey = GlobalKey<FormState>();

  Future<void> _selectDate(BuildContext context, controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
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
    if (_degreeController.text.trim().isEmpty ||
        _descriptionController.text.trim().isEmpty ||
        _endDateController.text.trim().isEmpty ||
        _startDateController.text.trim().isEmpty ||
        _organizationController.text.trim().isEmpty ||
        country == null ||
        state == null) {
      _showDialog();
      return;
    }

    widget.addEducation(
      Education(
        id: '1',
        degree: _degreeController.text,
        organization: _organizationController.text,
        startDate: _startDateController.text,
        endDate: _endDateController.text,
        description: _descriptionController.text,
        location: '${country!}, ${state!}, ',
        jobSeekerId: 2,
      ),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    _organizationController.dispose();
    _degreeController.dispose();
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
                    'Add Education',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                Expanded(
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
                            label: 'Degree',
                            controller: _degreeController,
                          ),
                          InputField(
                            label: 'Organization',
                            controller: _organizationController,
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
