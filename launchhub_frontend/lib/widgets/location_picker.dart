import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LocationPicker extends StatefulWidget {
  LocationPicker(
      {super.key,
      required this.country,
      required this.state,
      this.city,
      this.onCountryChanged,
      this.onStateChanged,
      this.onCityChanged});

  String? country;
  String? state;
  String? city;
  final void Function(String? value)? onCountryChanged;
  final void Function(String? value)? onStateChanged;
  final void Function(String? value)? onCityChanged;

  @override
  State<LocationPicker> createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  @override
  Widget build(BuildContext context) {
    return CSCPicker(
      dropdownDialogRadius: 10,
      dropdownHeadingStyle: Theme.of(context).textTheme.titleMedium,
      dropdownItemStyle: Theme.of(context).textTheme.bodyMedium!,
      searchBarRadius: 10,
      selectedItemStyle: Theme.of(context).textTheme.bodyMedium!,
      showCities: false,
      dropdownDecoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(10),
      ),
      onCountryChanged: (value) {
        setState(() {
          widget.country = value;
        });
        widget.onCountryChanged!(value);
      },
      onStateChanged: (value) {
        setState(() {
          widget.state = value;
        });
        widget.onStateChanged!(value);
      },
      onCityChanged: (value) {
        setState(() {
          widget.city = value;
        });
        widget.onCityChanged!(value);
      },
    );
  }
}
