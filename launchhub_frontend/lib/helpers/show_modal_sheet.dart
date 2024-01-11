import 'package:flutter/material.dart';

void showModal(Widget widget, context,
    {color, bool isDismissible = true, bool enableDrag = true}) {
  showModalBottomSheet(
      backgroundColor: color,
      elevation: 0,
      isScrollControlled: true,
      context: context,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      barrierColor: Colors.transparent,
      builder: (ctx) => widget);
}
