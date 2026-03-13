import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:whatsapp_clone/Services/Theme.dart';
import 'package:whatsapp_clone/Services/api_services.dart';
import 'package:whatsapp_clone/register.dart';
import 'package:whatsapp_clone/status_page.dart';

// Map<String, dynamic>? userData = {};

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _obscureText = true;
  final _formKey = GlobalKey<FormState>();
  var user, password;

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
                "Welcome, Please Login first before using this app",
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
                      return 'Please enter Username!';
                    }
                    user = username;
                    return null;
                  },
                ),
              ),
              SizedBox(
                // height: double.infinity,
                height: 50,
                width: double.infinity,
                child: TextFormField(
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    hintText: "Password",
                    hintStyle: TextStyle(),
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
                      return 'Please enter your password';
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
                    width: 100,
                    height: 35,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _login();
                        }
                        ;
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: warna.Hijau(),
                        foregroundColor: warna.Putih(),
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text("Login"),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Aksi yang ingin dilakukan saat teks "Don't have an account?" ditekan
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => register()),
                      );
                    },
                    child: Text(
                      "Don't have an account?",
                      style: TextStyle(
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

  void _login() async {
    // setState(() {

    // });

    var dataUser = {'name': user, 'password': password};

    var res = await ApiServices().httpPOST(
      data: dataUser,
      apiUrl: 'public/login',
    );
    // print(res.body);
    var body = jsonDecode(res.body);

    if (body['success']) {
      String token = body['token'];

      await AuthService().addToken(token);
      Navigator.pushNamedAndRemoveUntil(context, '/home', (Router) => false);
    }
  }
}
