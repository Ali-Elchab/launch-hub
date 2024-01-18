import 'package:flutter/material.dart';

Future<DateTime> selectDate(context, selectedDate) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: selectedDate ?? DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime(2101),
  );
  if (picked != null && picked != selectedDate) {
    return picked;
  }
  return selectedDate;
}
