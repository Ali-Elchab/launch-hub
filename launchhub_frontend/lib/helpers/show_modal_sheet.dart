import 'package:flutter/material.dart';

void showModal(Widget widget, context) {
  showModalBottomSheet(
      backgroundColor: Theme.of(context).colorScheme.primary,
      elevation: 0,
      isScrollControlled: true,
      context: context,
      isDismissible: true,
      enableDrag: false,
      barrierColor: Colors.transparent,
      builder: (ctx) => widget);
}
