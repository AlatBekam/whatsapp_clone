import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

class ApiServices {
  static const String _baseUrl = "http://10.0.2.2:8080/api/";

  Map<String, String> setHeadersToken(String? token) {
    if (token == null) return {'Content-type': 'application/json'};

    return {
      'Authorization': 'Bearer $token',
      'Content-type': 'application/json',
    };
  }

  auth({Map<String, dynamic>? data, required String apiUrl}) async {
    // Ensure proper URL concatenation
    String normalizedUrl = apiUrl.startsWith('/')
        ? apiUrl.substring(1)
        : apiUrl;
    var fullUrl = _baseUrl + normalizedUrl;
    Uri fullURL = Uri.parse(fullUrl);

    print("fullURL ${fullURL}");

    final token = await AuthService().getToken();

    return await http.post(
      fullURL,
      headers: setHeadersToken(token),
      body: jsonEncode(data),
    );
  }

  updateUser(data, apiURL) async {
    var fullUrl = _baseUrl + apiURL;
    Uri fullURL = Uri.parse(fullUrl);

    final token = await AuthService().getToken();
    return await http.post(
      fullURL,
      headers: setHeadersToken(token),
      body: jsonEncode(data),
    );
  }

  register(data, apiUrl) async {
    var fullUrl = _baseUrl + apiUrl;
    Uri fullURL = Uri.parse(fullUrl);

    return await http.post(
      fullURL,
      headers: setHeadersToken(null),
      body: jsonEncode(data),
    );
  }

  Future dptToken() async {
    final token = await AuthService().getToken();
    var iD = JwtDecoder.decode(token!)['id'].toString();
    return iD;
  }

  Future getData(apiUrl) async {
    // Ensure proper URL concatenation
    var fullUrl = _baseUrl + apiUrl;
    Uri fullURL = Uri.parse(fullUrl);

    final token = await AuthService().getToken();
    print("1 Token used: $token");
    print("2 Request URL: $fullURL");
    print("3 Headers: ${setHeadersToken(token)}");
    var idUser = JwtDecoder.decode(token!)['id'];
    ;

    final response = await http.get(fullURL, headers: setHeadersToken(token));

    print("4 Response Status: ${response.statusCode}");
    print("5 Response Body: ${response.body}");

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
  Future<Map<String, dynamic>> sendMessage(
    String receiverId,
    String message,
  ) async {
    var fullUrl = _baseUrl + "messages";
    Uri fullURL = Uri.parse(fullUrl);

    final token = await AuthService().getToken();

    final response = await http.post(
      fullURL,
      headers: setHeadersToken(token),
      body: jsonEncode({'receiver_id': receiverId, 'message': message}),
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

    final token = await AuthService().getToken();

    final response = await http.get(fullURL, headers: setHeadersToken(token));

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

  Future<dynamic> postData(data, apiUrl) async {
    var fullUrl = _baseUrl + apiUrl;
    Uri fullURL = Uri.parse(fullUrl);

    final token = await AuthService().getToken();
    var resp = await http.post(
      fullURL,
      headers: setHeadersToken(token),
      body: jsonEncode(data),
    );

    print("resp ${resp.body}");
    var dataBody = jsonDecode(resp.body);
    if (dataBody['error']?.runtimeType == String) {
      print("Error Here: ${dataBody['error']}");
      return null;
    } else {
      print("Body Result: $dataBody");
      return dataBody;
    }
  }

  // ini bise pake postData tok, drpd buat kelas masing-masing
  Future<Map<String, dynamic>> createCommunity(String name, String desc) async {
    var url = "private/community";

    Map<String, dynamic> data = {
      "community_name": name,
      "description": desc,
      "announcement_group_id": null,
    };

    return await postData(data, url);
  }

  Future<List<dynamic>> getCommunity() async {
    var url = _baseUrl + "private/community";
    final token = await AuthService().getToken();
    var response = await http.get(
      Uri.parse(url),
      headers: await setHeadersToken(token),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load community");
    }
  }

  Future deleteCommunity(String id) async {
    var url = _baseUrl + "private/community/$id";
    final token = await AuthService().getToken();

    return await http.delete(
      Uri.parse(url),
      headers: await setHeadersToken(token),
    );
  }

  Future updateCommunity(String id, String name, String desc) async {
    var url = _baseUrl + "private/community/$id";
    final token = await AuthService().getToken();
    Map data = {"community_name": name, "description": desc};
    return await http.put(
      Uri.parse(url),
      headers: await setHeadersToken(token),
      body: jsonEncode(data),
    );
  }
}

class AuthService {
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

// GET, POST, DELETE, UPDATE / PUT

class HttpServices {
  Future<Map<String, String>> headers() async => {
    'Authorization': 'Bearer ${await AuthService().getToken()}',
    'Content-type': 'application/json',
  };
  static Future get(String url, {Map<String, dynamic>? data}) async {
    var headers = await HttpServices().headers();
    await http
        .get(Uri.parse(ApiServices._baseUrl + url), headers: headers)
        .then((response) {
          if (response.statusCode == 200) {
            var data = jsonDecode(response.body);
            print("data Result: $data");
            return data;
          } else {
            print("error: ${response.body}");
          }
          if (response.statusCode == 401) {
            print("Unauth");
            throw Exception(["Unauth"]);
          }
        });
  }

  static Future post(String url, {Map<String, dynamic>? data}) async {
    var headers = await HttpServices().headers();
    await http
        .post(
          Uri.parse(ApiServices._baseUrl + url),
          headers: headers,
          body: jsonEncode(Map.from(data ?? {})),
        )
        .then((response) {
          print("response.body: ${response.body}");
          print("response.statusCode: ${response.statusCode}");
          if (response.statusCode.toString() == "200") {
            var data = jsonDecode(response.body);
            return data;
          }
          if (response.statusCode.toString() == "401") {
            print("Unauth");
            throw Exception(["Unauth"]);
          }
        });
  }
}
