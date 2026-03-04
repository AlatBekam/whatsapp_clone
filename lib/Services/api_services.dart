import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiServices {
  final FlutterSecureStorage storedToken = FlutterSecureStorage();
  static const String _baseUrl = "http://10.0.2.2:8080/api/";

  Map<String, String> _setHeaders() => {'Content-type': 'application/json'};

  auth(data, apiUrl) async {
    var fullUrl = _baseUrl + apiUrl;
    Uri fullURL = Uri.parse(fullUrl);

    return await http.post(
      fullURL,
      headers: _setHeaders(),
      body: jsonEncode(data),
    );
  }

  register(data, apiUrl) async {
    var fullUrl = _baseUrl + apiUrl;
    Uri fullURL = Uri.parse(fullUrl);

    return await http.post(
      fullURL,
      headers: _setHeaders(),
      body: jsonEncode(data),
    );
  }

  getData(apiUrl) async {
    var fullUrl = _baseUrl + apiUrl;
    Uri fullURL = Uri.parse(fullUrl);

    await authService().getToken();
    return await http.get(fullURL, headers: _setHeaders());
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

class authService {
  final FlutterSecureStorage _storedToken = FlutterSecureStorage();

  Future<void> addToken(String token) async {
    await _storedToken.write(key: 'token', value: token);
  }

  Future<String?> getToken() async {
    return await _storedToken.read(key: 'token');
  }

  Future<void> removeToken() async {
    await _storedToken.delete(key: 'token');
  }
}
