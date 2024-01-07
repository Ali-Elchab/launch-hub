import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:launchhub_frontend/data/mockData.dart';
import 'package:launchhub_frontend/models/industry.dart';
import 'package:launchhub_frontend/models/jobPost.dart';
import 'package:launchhub_frontend/widgets/auth_widgets/industry_drop_down.dart';

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
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Industry? _selectedIndustry;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      _selectedDate = pickedDate;
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
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
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
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
      child: SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                maxLength: 50,
                decoration: const InputDecoration(
                  label: Text('Title'),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        prefixText: '\$ ',
                        label: Text('Amount'),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          _selectedDate == null
                              ? 'No date selected'
                              : DateFormat('yyyy-MM-dd').format(_selectedDate!),
                        ),
                        IconButton(
                          onPressed: _presentDatePicker,
                          icon: const Icon(
                            Icons.calendar_month,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: IndustryDropDown(
                      list: industries,
                      value: _selectedIndustry,
                      validator: (value) {
                        if (value == null) {
                          return 'This field cannot be empty';
                        }
                        return null;
                      },
                      onChanged: (Industry? newValue) {
                        setState(() {
                          _selectedIndustry = newValue;
                        });
                      },
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: _submitJobData,
                    child: const Text('Save Expense'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//  @override
//   Widget build(BuildContext context) {
//     final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
//     return LayoutBuilder(builder: (ctx, constraints) {
//       return SizedBox(
//         height: double.infinity,
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
