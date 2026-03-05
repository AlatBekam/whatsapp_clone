import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiServices {
  final FlutterSecureStorage storedToken = FlutterSecureStorage();
  static const String _baseUrl = "http://10.0.2.2:8080/api";

  Map<String, String> _setHeaders() => {'Content-type': 'application/json'};
  Map<String, String> _setHeadersToken(token) => {
    if (token != null) 'Authorization': 'Bearer $token',
    'Content-type': 'application/json',
  };

  auth(data, apiUrl) async {
    // Ensure proper URL concatenation
    String normalizedUrl = apiUrl.startsWith('/') ? apiUrl : '/$apiUrl';
    var fullUrl = _baseUrl + normalizedUrl;
    Uri fullURL = Uri.parse(fullUrl);

    final token = await authService().getToken();
    
    return await http.post(
      fullURL,
      headers: _setHeadersToken(token),
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

  Future getData(apiUrl) async {
    // Ensure proper URL concatenation
    String normalizedUrl = apiUrl.startsWith('/') ? apiUrl : '/$apiUrl';
    var fullUrl = _baseUrl + normalizedUrl;
    Uri fullURL = Uri.parse(fullUrl);

    final token = await authService().getToken();
    print("Token used: $token");
    print("Request URL: $fullURL");
    print("Headers: ${_setHeadersToken(token)}");
    
    final response = await http.get(fullURL, headers: _setHeadersToken(token));
    
    print("Response Status: ${response.statusCode}");
    print("Response Body: ${response.body}");

    if (response.statusCode == 200) {
      final body = response.body;
      if (body.isEmpty) {
        return []; // Return empty list for empty response
      }
      return jsonDecode(body);
    }

    if (response.statusCode == 401) {
      throw Exception("UNAUTHORIZED");
    }
    
    // Handle other status codes
    throw Exception("Server error: ${response.statusCode}");
  }

  /// Send a message to the server
  /// [receiverId] - ID of the message recipient
  /// [message] - The message content
  Future<Map<String, dynamic>> sendMessage(String receiverId, String message) async {
    var fullUrl = _baseUrl + "messages";
    Uri fullURL = Uri.parse(fullUrl);

    final token = await authService().getToken();
    
    final response = await http.post(
      fullURL,
      headers: _setHeadersToken(token),
      body: jsonEncode({
        'receiver_id': receiverId,
        'message': message,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to send message: ${response.statusCode}");
    }
  }

  /// Get chat history with a specific user
  /// [userId] - ID of the other user in the conversation
  Future<List<Map<String, dynamic>>> getMessages(String userId) async {
    var fullUrl = _baseUrl + "messages/$userId";
    Uri fullURL = Uri.parse(fullUrl);

    final token = await authService().getToken();
    
    final response = await http.get(fullURL, headers: _setHeadersToken(token));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // Assuming response is a list of messages
      if (data is List) {
        return List<Map<String, dynamic>>.from(data);
      }
      // If response has a 'messages' key
      if (data['messages'] != null) {
        return List<Map<String, dynamic>>.from(data['messages']);
      }
      return [];
    } else {
      throw Exception("Failed to get messages: ${response.statusCode}");
    }
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
