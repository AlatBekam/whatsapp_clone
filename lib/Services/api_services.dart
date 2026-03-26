import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:whatsapp_clone/Services/route_handler.dart';

class ApiServices {
  static const String _baseUrl = "http://10.0.2.2:8080/api/";
  final _token = AuthService().getToken();

  Map<String, String> _setHeadersToken(String? token) {
    if (token == null) return {'Content-type': 'application/json'};

    return {
      'Authorization': 'Bearer $token',
      'Content-type': 'application/json',
    };
  }

  void _checkResponse(int StatusCode) async {
    if (StatusCode == 401) {
      await AuthService().removeToken();

      Get.offAllNamed(Routes.login);
    }
  }

  Future<String?> uploadImageWithToken({
  required File file,
  required String apiUrl,
}) async {
  var uri = Uri.parse(_baseUrl + apiUrl);

  var request = http.MultipartRequest("POST", uri);

  final token = await AuthService().getToken();
  print('token: $token');

  request.headers['Authorization'] = 'Bearer $token';

  request.files.add(
    await http.MultipartFile.fromPath(
      "image",
      file.path,
    ),
  );

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

    _checkResponse(resp.statusCode);

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
      headers: _setHeadersToken(await _token),
      body: jsonEncode(data),
    );

    _checkResponse(resp.statusCode);

    return resp;
  }

  httpGET(String apiUrl) async {
    var fullUrl = _baseUrl + apiUrl;
    Uri fullURL = Uri.parse(fullUrl);

    var resp = await http.get(fullURL, headers: _setHeadersToken(null));

    _checkResponse(resp.statusCode);

    return resp;
  }

  httpGETWithToken(String apiUrl) async {
    var fullUrl = _baseUrl + apiUrl;
    Uri fullURL = Uri.parse(fullUrl);

    var resp = await http.get(fullURL, headers: _setHeadersToken(await _token));

    _checkResponse(resp.statusCode);

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

    _checkResponse(resp.statusCode);

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
      headers: _setHeadersToken(await _token),
      body: jsonEncode(data),
    );

    _checkResponse(resp.statusCode);

    return resp;
  }

  Future httpDELETEWithToken(String apiUrl) async {
    var fullUrl = _baseUrl + apiUrl;
    Uri fullURL = Uri.parse(fullUrl);

    var resp = await http.delete(
      fullURL,
      headers: _setHeadersToken(await _token),
    );

    _checkResponse(resp.statusCode);

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
