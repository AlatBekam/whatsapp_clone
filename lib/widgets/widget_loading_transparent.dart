import 'package:flutter/material.dart';

Widget widgetLoadingTransparent(BuildContext context) {
  return Positioned.fill(
    child: Container(
      color: Theme.of(context).colorScheme.surface.withAlpha(50),
      child: const Center(child: CircularProgressIndicator()),
    ),
  );
}
