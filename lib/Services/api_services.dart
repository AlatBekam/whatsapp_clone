import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:whatsapp_clone/services/route_handler.dart';

class ApiServices {
  static const String _baseUrl = "http://10.0.2.2:8080/api/";

  Map<String, String> _setHeadersToken(String? token) {
    if (token == null) return {'Content-type': 'application/json'};

    return {
      'Authorization': 'Bearer $token',
      'Content-type': 'application/json',
    };
  }

  void _checkResponse(int StatusCode, dynamic body) async {
    if (StatusCode == 401) {
      // if (body["error"] == "") {
      //   Get.snackbar("Error", body["error"]);
      // }
      await AuthService().removeToken();
      AlertDialog alert = AlertDialog(
        title: Text("Your section already expired"),
        content: Text("Please login again"),
        actions: [
          ElevatedButton(
            onPressed: () {
              Get.offAllNamed(Routes.login);
            },
            child: Text("OK"),
          ),
        ],
      );

      showDialog(context: Get.context!, builder: (context) => alert);
    }

    if (StatusCode == 200 || StatusCode == 201) {
      // print("ini body $body");
      // if (body["response-message"].isNotEmpty &&
      //     body["response-message"] != null) {
      //   Get.snackbar(
      //     "Success",
      //     body["response-message"],
      //     snackPosition: SnackPosition.BOTTOM,
      //   );
      // }
    }

    if (StatusCode == 409) {
      Get.snackbar(
        "Error",
        body["error"] ?? "Conflic",
        snackPosition: SnackPosition.BOTTOM,
      );
    }

    if (StatusCode == 400) {
      Get.snackbar(
        "Error",
        body["error"] ?? "Bad request",
        snackPosition: SnackPosition.BOTTOM,
      );
    }

    if (StatusCode == 404) {
      Get.snackbar(
        "Error",
        body["error"] ?? "Not found",
        snackPosition: SnackPosition.BOTTOM,
      );
    }

    if (StatusCode == 500) {
      Get.snackbar(
        "Error",
        body["error"] ?? "Internal server error",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<String?> uploadImageWithTokens({
    required File file,
    required String apiUrl,
    required String paths,
  }) async {
    var uri = Uri.parse(_baseUrl + apiUrl);

    var request = http.MultipartRequest("POST", uri);

    request.headers['Authorization'] =
        'Bearer ${await AuthService().getToken()}';
    request.fields['paths'] = paths;
    print("request path: ${request.fields['paths']}");

    request.files.add(await http.MultipartFile.fromPath("image", file.path));

    print("request: $request");

    var response = await request.send();

    if (response.statusCode == 200) {
      final res = await response.stream.bytesToString();
      final data = jsonDecode(res);
      return data["url"];
    }

    return null;
  }

  httpPOST({Map<String, dynamic>? data, required String apiUrl}) async {
    var fullUrl = _baseUrl + apiUrl;
    Uri fullURL = Uri.parse(fullUrl);

    var resp = await http.post(
      fullURL,
      headers: _setHeadersToken(null),
      body: jsonEncode(data),
    );

    _checkResponse(resp.statusCode, jsonDecode(resp.body));

    return resp;
  }

  httpPOSTWithToken({
    Map<String, dynamic>? data,
    required String apiUrl,
  }) async {
    var fullUrl = _baseUrl + apiUrl;
    Uri fullURL = Uri.parse(fullUrl);

    var resp = await http.post(
      fullURL,
      headers: _setHeadersToken(await AuthService().getToken()),
      body: jsonEncode(data),
    );

    print("resp: ${resp.body}");

    _checkResponse(resp.statusCode, jsonDecode(resp.body));

    return resp;
  }

  httpGET(String apiUrl) async {
    var fullUrl = _baseUrl + apiUrl;
    Uri fullURL = Uri.parse(fullUrl);

    var resp = await http.get(fullURL, headers: _setHeadersToken(null));

    _checkResponse(resp.statusCode, jsonDecode(resp.body));

    return resp;
  }

  httpGETWithToken(String apiUrl) async {
    var fullUrl = _baseUrl + apiUrl;
    Uri fullURL = Uri.parse(fullUrl);

    var resp = await http.get(
      fullURL,
      headers: _setHeadersToken(await AuthService().getToken()),
    );

    _checkResponse(resp.statusCode, resp.body);

    return resp;
  }

  httpPUT({Map<String, dynamic>? data, required String apiUrl}) async {
    var fullUrl = _baseUrl + apiUrl;
    Uri fullURL = Uri.parse(fullUrl);

    var resp = await http.post(
      fullURL,
      headers: _setHeadersToken(null),
      body: jsonEncode(data),
    );

    _checkResponse(resp.statusCode, resp.body);

    return resp;
  }

  Future httpPUTWithToken({
    Map<String, dynamic>? data,
    required String apiUrl,
  }) async {
    var fullUrl = _baseUrl + apiUrl;
    Uri fullURL = Uri.parse(fullUrl);

    var resp = await http.put(
      fullURL,
      headers: _setHeadersToken(await AuthService().getToken()),
      body: jsonEncode(data),
    );

    _checkResponse(resp.statusCode, resp.body);

    return resp;
  }

  Future httpDELETEWithToken(String apiUrl) async {
    var fullUrl = _baseUrl + apiUrl;
    Uri fullURL = Uri.parse(fullUrl);

    var resp = await http.delete(
      fullURL,
      headers: _setHeadersToken(await AuthService().getToken()),
    );

    _checkResponse(resp.statusCode, resp.body);

    return resp;
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
