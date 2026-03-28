import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/controllers/status_controller.dart';
import 'package:whatsapp_clone/pages/status/status_page.dart';
import 'package:whatsapp_clone/widgets/enum_status.dart';

class addStatus extends StatefulWidget {
  const addStatus({super.key});

  @override
  _addStatusState createState() => _addStatusState();
}

class _addStatusState extends State<addStatus> {
  final _formKey = GlobalKey<FormState>();
  var contentStatus;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Form(
          key: _formKey,
          child: Stack(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Type a Status",
                      border: InputBorder.none,
                      hintStyle: TextStyle(fontSize: ukText + 3),
                    ),
                    textAlign: TextAlign.center,

                    validator: (statusContent) {
                      if (statusContent == null) {
                        return 'Please enter Channel Name!';
                      }

                      contentStatus = statusContent;
                      return null;
                    },
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 130,
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                height: 45,
                                width: 45,
                                margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.secondary,
                                  shape: BoxShape.circle,
                                ),
                                child: SvgPicture.asset(
                                  'assets/svg/close-X.svg',
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSecondary,
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
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.secondary,
                                      shape: BoxShape.circle,
                                    ),
                                    child: SvgPicture.asset(
                                      'assets/svg/letter-a.svg',
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onSecondary,
                                    ),
                                  ),
                                  Container(
                                    height: 45,
                                    width: 45,
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.secondary,
                                      shape: BoxShape.circle,
                                    ),
                                    child: SvgPicture.asset(
                                      'assets/svg/color-palette.svg',
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 70,
                        width: MediaQuery.of(context).size.width,
                        child: Container(
                          // color: warna.AbuAbuTua(),
                          padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            spacing: 10,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 35,
                                    decoration: BoxDecoration(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.secondary,
                                      borderRadius: BorderRadius.circular(35),
                                    ),
                                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      spacing: 5,
                                      children: [
                                        SvgPicture.asset(
                                          'assets/svg/logopembaruan.svg',
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.onSecondary,
                                          width: 20,
                                          height: 20,
                                        ),

                                        Text(
                                          'Status (10 Excluded)',
                                          style: Theme.of(
                                            context,
                                          ).textTheme.displaySmall,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              Obx(() {
                                if (controllerStatus.status.value ==
                                    Status.loading) {
                                  return Container(
                                    width: 45,
                                    height: 45,
                                    decoration: BoxDecoration(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.secondary,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.onSecondary,
                                      ),
                                    ),
                                  );
                                }

                                return GestureDetector(
                                  onTap: () async {
                                    if (_formKey.currentState!.validate()) {
                                      bool success = await controllerStatus
                                          .addStatus(contentStatus);

                                      if (success) {
                                        Get.back(result: true);
                                      }
                                    }
                                  },

                                  child: Container(
                                    width: 45,
                                    height: 45,
                                    decoration: BoxDecoration(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.secondary,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: SvgPicture.asset(
                                        'assets/svg/paper-plane-right.svg',
                                        width: 20,
                                        height: 20,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.onSecondary,
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
