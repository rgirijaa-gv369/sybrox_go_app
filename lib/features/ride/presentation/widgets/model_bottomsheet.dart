import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showAppBottomSheet(
  BuildContext context, {
  required Widget child,
  bool isDraggable = false,
  double initialSize = 0.4,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.black.withOpacity(0.4),
    builder: (_) {
      if (isDraggable) {
        return DraggableScrollableSheet(
          initialChildSize: initialSize,
          minChildSize: 0.25,
          maxChildSize: 0.9,
          builder: (_, controller) {
            return SingleChildScrollView(controller: controller, child: child);
          },
        );
      }
      return child;
    },
  );
}
