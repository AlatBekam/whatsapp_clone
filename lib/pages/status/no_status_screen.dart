import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/services/route_handler.dart';

class NoStatusScreen extends StatelessWidget {
  const NoStatusScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40.0),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'No status from your friends, \nstart making status or add a new friend!',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelMedium,
            ),

            const SizedBox(height: 16),

            SvgPicture.asset(
              'assets/svg/person-group.svg',
              width: 200,
              color: Theme.of(context).colorScheme.onSurface,
            ),

            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    await Get.toNamed(Routes.addStatus);
                  },
                  child: const Text('Add Status'),
                ),
                ElevatedButton(
                  onPressed: () {
                    print('asda');
                  },
                  child: const Text('Add Friend'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
