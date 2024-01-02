import 'package:flutter/material.dart';
import 'package:launchhub_frontend/screens/auth_screens/signin.dart';
import 'package:launchhub_frontend/widgets/auth_widgets/date_picker.dart';
import 'package:launchhub_frontend/widgets/custom_appbar.dart';
import 'package:launchhub_frontend/widgets/input_field.dart';
import 'package:launchhub_frontend/widgets/small_button.dart';
import 'package:intl/intl.dart';

class CompanyInfo1 extends StatefulWidget {
  const CompanyInfo1({super.key});

  @override
  State<CompanyInfo1> createState() => _CompanyInfo1State();
}

class _CompanyInfo1State extends State<CompanyInfo1> {
  DateTime? selectedDate;
  final TextEditingController _controller = TextEditingController();
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    print('aaaaaaaaaaaaaaaaaaaaaaa');
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _controller.text =
            DateFormat('yyyy-MM-dd').format(picked); // Format date as required
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const CustomAppBar(title: 'Startup Profile'),
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          width: 280,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,

            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    'Company Information',
                    textAlign: TextAlign.left,
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(fontWeight: FontWeight.w700, fontSize: 22),
                  ),
                ),
              ),
              const SizedBox(height: 35),
              const HeaderSection(),
              const SizedBox(height: 16),
              const InputField(label: 'Company Name'),
              const SizedBox(height: 16),
              DatePickerField(
                controller: _controller,
                onTap: () => _selectDate(context),
              ),
              const SizedBox(height: 16),
              const InputField(label: 'Legal Structure'),
              const SizedBox(height: 16),
              const InputField(label: 'Email'),
              const SizedBox(height: 16),
              const InputField(label: 'Email'),
              const SizedBox(height: 16),
              const InputField(label: 'Email'),
              const SizedBox(height: 80),
              SmallButton('Next', () {}),
              const SizedBox(height: 16),
              Text(
                'This information will be showcased to job seekers, helping them make informed decisions about opportunities with your company.',
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontWeight: FontWeight.w100,
                    fontSize: 11,
                    color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
