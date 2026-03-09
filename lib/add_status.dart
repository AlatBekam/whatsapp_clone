import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:whatsapp_clone/Services/Theme.dart';
import 'package:whatsapp_clone/Services/api_services.dart';
import 'package:whatsapp_clone/status_page.dart';

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
                  height: 70,
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    color: warna.AbuAbuTua(),
                    padding: EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: 10,
                      children: [
                        Row(
                          children: [
                            Container(
                              child: Text(
                                'sdasda',
                                style: TextStyle(color: warna.Putih()),
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            return null;
                          },

                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: warna.Hijau(),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                'assets/paper-plane-right.svg',
                                width: 20,
                                height: 20,
                                color: warna.Putih(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _addStatus() async {
    // var dataChannel = {
    // };

    // var res = await ApiServices().httpPOSTWithToken(
    //   data: dataChannel,
    //   apiUrl: 'public/channels',
    // );

    // var body = jsonDecode(res.body);
    // if (body['success']) {
    //   Navigator.pop(context);
    // }
  }
}
