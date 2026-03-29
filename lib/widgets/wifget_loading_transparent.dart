import 'package:flutter/material.dart';

Widget loadingTransparent(BuildContext context) {
  return Container(
    color: Theme.of(context).colorScheme.surface.withAlpha(50),
    child: Center(child: CircularProgressIndicator()),
  );
}
