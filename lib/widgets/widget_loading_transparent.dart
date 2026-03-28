import 'package:flutter/material.dart';

Widget widgetLoadingTransparent(BuildContext context) {
  return Container(
    color: Theme.of(context).colorScheme.surface.withAlpha(50),
    child: Center(child: CircularProgressIndicator()),
  );
}
