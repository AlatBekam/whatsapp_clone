import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/controllers/auth_controller.dart';
import 'package:whatsapp_clone/services/route_handler.dart';
import 'package:whatsapp_clone/services/theme/theme.dart';
import 'package:whatsapp_clone/Services/api_services.dart';
import 'package:whatsapp_clone/pages/status/status_page.dart';
import 'package:whatsapp_clone/screens/login.dart';

class register extends StatefulWidget {
  const register({super.key});

  @override
  _registerState createState() => _registerState();
}

class _registerState extends State<register> {
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  var user, email, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(10, 100, 10, 10),
        child: Form(
          key: _formKey,
          child: Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome, Please input your data to register',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Username",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 10.0),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),

                  validator: (username) {
                    if (username == null || username.isEmpty) {
                      return "Please enter your Name";
                    }

                    user = username;
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Email",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 10.0),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),

                  validator: (emaill) {
                    if (emaill == null || emaill.isEmpty) {
                      return "Please enter your Email";
                    }

                    email = emaill;
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: TextFormField(
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    hintText: "Password",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 10.0),
                      borderRadius: BorderRadius.circular(20),
                    ),

                    suffixIcon: GestureDetector(
                      onTap: () {
                        // Aksi yang ingin dilakukan saat ikon ditekan
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      child: Icon(Icons.visibility),
                    ),
                  ),

                  validator: (passwordd) {
                    if (passwordd == null || passwordd.isEmpty) {
                      return "Please enter your Password";
                    }

                    password = passwordd;
                    return null;
                  },
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 120,
                    height: 35,
                    child: ElevatedButton(
                      onPressed: () {
                        print(user);
                        print(email);
                        print(password);

                        if (_formKey.currentState!.validate()) {
                          controllerAuth.register(user, email, password);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: warna.Hijau(),
                        foregroundColor: Colors.white,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Register',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.login);
                    },
                    child: Text(
                      'Already have an account? Login',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
