import 'package:flutter/material.dart';

Widget widgetLoading(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height,
    color: Theme.of(context).colorScheme.surface,
    child: const Center(child: CircularProgressIndicator()),
  );
}
