import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

Stack addStatusText(
  BuildContext context,
  TextEditingController controller,
  Function(String) onChanged,
) {
  return Stack(
    children: [
      Center(
        child: TextFormField(
          controller: controller,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: "Type a Status",
            border: InputBorder.none,
            hintStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          textAlign: TextAlign.center,
          validator: (statusContent) {
            if (statusContent == null || statusContent.trim().isEmpty) {
              return 'Please enter a status!';
            }
            return null;
          },
        ),
      ),

      Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          height: 130,
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  height: 45,
                  width: 45,
                  margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(
                    'assets/svg/close-X.svg',
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                ),
              ),

              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 15, 0),
                child: Row(
                  spacing: 5,
                  children: [
                    Container(
                      height: 45,
                      width: 45,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset(
                        'assets/svg/letter-a.svg',
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                    ),
                    Container(
                      height: 45,
                      width: 45,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset(
                        'assets/svg/color-palette.svg',
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
