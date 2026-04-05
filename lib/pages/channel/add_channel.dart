import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/controllers/channel_controller.dart';
import 'package:whatsapp_clone/controllers/loading_controller.dart';
import 'package:whatsapp_clone/services/theme/theme.dart';
import 'package:whatsapp_clone/widgets/enum_status.dart';

class addChannel extends StatefulWidget {
  const addChannel({super.key});

  @override
  _addChannelState createState() => _addChannelState();
}

class _addChannelState extends State<addChannel> {
  final _formKey = GlobalKey<FormState>();
  var nameChannel, descriptionChannel, typeChannel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add New Channel!')),

      body: Container(
        padding: EdgeInsets.fromLTRB(10, 50, 10, 30),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 15,
                children: [
                  SvgPicture.asset(
                    'assets/svg/person-group.svg',
                    width: 200,
                    color: warna.AbuAbu(),
                  ),

                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Channel Name",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 10.0),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),

                      validator: (channelName) {
                        if (channelName == null) {
                          return 'Please enter Channel Name!';
                        }

                        nameChannel = channelName;
                        return null;
                      },
                    ),
                  ),

                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Channel Type",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 10.0),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),

                      validator: (channelType) {
                        if (channelType == null) {
                          return 'Please enter Channel Type!';
                        }

                        typeChannel = channelType;
                        return null;
                      },
                    ),
                  ),

                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Description",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 10.0),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),

                      validator: (channelDescription) {
                        if (channelDescription == null) {
                          return 'Please enter Channel Description';
                        }

                        descriptionChannel = channelDescription;
                        return null;
                      },
                    ),
                  ),
                ],
              ),

              Obx(() {
                return SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        bool success = await controllerChannel.addChannel(
                          nameChannel,
                          typeChannel,
                          descriptionChannel,
                        );

                        if (success) {
                          Get.back(result: true);
                        }
                      }
                    },
                    style: switch (loadingController.dataState(
                      Keys.dataFeatureChannelState,
                    )) {
                      DataState.empty => ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: warna.Hijau(),
                        foregroundColor: warna.Putih(),
                        shadowColor: Colors.transparent,
                      ),
                      DataState.loading => ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: warna.AbuAbu(),
                        foregroundColor: warna.Putih(),
                        shadowColor: Colors.transparent,
                      ),
                      DataState.error => ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: warna.Merah(),
                        foregroundColor: warna.Putih(),
                        shadowColor: Colors.transparent,
                      ),
                      DataState.success => ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: warna.Hijau(),
                        foregroundColor: warna.Putih(),
                        shadowColor: Colors.transparent,
                      ),
                    },
                    child: switch (loadingController.dataState(
                      Keys.dataFeatureChannelState,
                    )) {
                      DataState.empty => Text('Add Channel'),
                      DataState.loading => Container(
                        width: 15,
                        height: 15,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                      DataState.error => Text('Error'),
                      DataState.success => Text('Add Channel'),
                    },
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
