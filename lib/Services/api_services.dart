import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiServices {
  static const String _baseUrl = "http://10.0.2.2:8080/api/";
  var token;

  static _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String? storedToken = localStorage.getString('token');

    if (storedToken != null) {
      var data = jsonDecode(storedToken);
      print(data);
    } else {
      print("Token tidak ditemukan");
    }
  }

  Map<String, String> _setHeaders() => {'Content-type': 'application/json'};

  auth(data, apiUrl) async {
    var fullUrl = _baseUrl + apiUrl;
    Uri fullURL = Uri.parse(fullUrl);

    await _getToken();
    return await http.post(
      fullURL,
      headers: _setHeaders(),
      body: jsonEncode(data),
    );
  }

  // static Future<List<Map<String, dynamic>>> fetchUser() async {
  //   try {
  //     final response = await http.get(Uri.parse('$baseUrl/users'));
  //   }

  //   // Simulate an API call with a delay
  //   // await Future.delayed(Duration(seconds: 2));
  //   // return [
  //   //   {'title': 'Alice', 'subtitle': 'Hey there!'},
  //   //   {'title': 'Bob', 'subtitle': 'What\'s up?'},
  //   //   {'title': 'Charlie', 'subtitle': 'Let\'s catch up soon.'},
  //   // ];
  // }

  // static Future<void> createUser(String name, String email) async {
  //   try {
  //     final response = await http.post(
  //       Uri.parse('$baseUrl/users'),
  //       body: {'name': name, 'email': email},
  //     );
  //     if (response.statusCode == 201) {
  //       print('User created successfully');
  //     } else {
  //       print('Failed to create user: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     print('Error creating user: $e');
  //   }
  // }
}
