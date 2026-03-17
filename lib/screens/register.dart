import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:whatsapp_clone/services/Theme.dart';
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
                style: TextStyle(fontSize: ukText),
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
                    if (username == null) {
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
                    if (emaill == null) {
                      return "Please enter your Name";
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
                    if (passwordd == null) {
                      return "Please enter your Name";
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
                        if (_formKey.currentState!.validate()) {
                          _register();
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
                      child: Text('Register'),
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                      );
                    },
                    child: Text(
                      'Already have an account? Login',
                      style: TextStyle(color: Colors.blue),
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

  void _register() async {
    var dataUser = {'name': user, 'email': email, 'password': password};

    var res = await ApiServices().httpPOST(
      data: dataUser,
      apiUrl: 'public/users',
    );

    var body = jsonDecode(res.body);

    if (body['success']) {
      Navigator.pushReplacementNamed(context, '/login');
    } else if (body['success'] == false) {
      print(body['message']);
    }
  }
}
