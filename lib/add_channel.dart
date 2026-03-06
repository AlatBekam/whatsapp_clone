import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:whatsapp_clone/Services/Theme.dart';
import 'package:whatsapp_clone/Services/api_services.dart';
import 'package:whatsapp_clone/status_page.dart';

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
                    'assets/person-group.svg',
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

              SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _addChannel();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: warna.Hijau(),
                    foregroundColor: warna.Putih(),
                    shadowColor: Colors.transparent,
                  ),
                  child: Text('Add Channel'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _addChannel() async {
    var dataChannel = {
      'channel_name': nameChannel,
      'channel_type': typeChannel,
      'description': descriptionChannel,
    };

    var res = await ApiServices().auth(
      data: dataChannel,
      apiUrl: 'public/channels',
    );

    var body = jsonDecode(res.body);
    if (body['success']) {
      Navigator.pop(context);
    }
  }
}
