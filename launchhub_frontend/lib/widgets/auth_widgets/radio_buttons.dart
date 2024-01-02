import 'package:flutter/material.dart';

enum UserType { jobseeker, startup }

class RadioButtons extends StatefulWidget {
  const RadioButtons({super.key, required this.onSelectionChanged});
  final Function onSelectionChanged;
  @override
  State<RadioButtons> createState() => _RadioButtonsState();
}

class _RadioButtonsState extends State<RadioButtons> {
  UserType? _type = UserType.jobseeker;

  void _handleRadioValueChanged(UserType? value) {
    if (value != null) {
      widget.onSelectionChanged(value);
    }
    setState(() {
      _type = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(children: [
          Radio<UserType>(
            activeColor: Theme.of(context).colorScheme.inversePrimary,
            value: UserType.startup,
            groupValue: _type,
            onChanged: _handleRadioValueChanged,
          ),
          const Text('Startup'),
        ]),
        Row(children: [
          Radio<UserType>(
            activeColor: Theme.of(context).colorScheme.inversePrimary,
            value: UserType.jobseeker,
            groupValue: _type,
            onChanged: (UserType? value) {
              setState(() {
                _type = value;
              });
            },
          ),
          const Text('Job Seeker'),
        ]),
      ],
    );
  }
}
