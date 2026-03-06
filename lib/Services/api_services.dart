import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  static const String _baseUrl = "http://10.0.2.2:8080/api/";

  Map<String, String> _setHeadersToken(String? token) => {
    if (token != null) 'Authorization': 'Bearer $token',
    'Content-type': 'application/json',

    if (token == null) 'Content-type': 'application/json',
  };

  auth(data, apiUrl) async {
    var fullUrl = _baseUrl + apiUrl;
    Uri fullURL = Uri.parse(fullUrl);

    return await http.post(
      fullURL,
      headers: _setHeadersToken(null),
      body: jsonEncode(data),
    );
  }

  updateUser(data, apiURL) async {
    var fullUrl = _baseUrl + apiURL;
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
      headers: _setHeadersToken(null),
      body: jsonEncode(data),
    );
  }

  Future getData(apiUrl) async {
    var fullUrl = _baseUrl + apiUrl;
    Uri fullURL = Uri.parse(fullUrl);

    final token = await authService().getToken();
    // print("TOKEN: $token");
    final response = await http.get(fullURL, headers: _setHeadersToken(token));
    // print(_setHeadersToken(token));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    if (response.statusCode == 401) {
      // print(jsonDecode(response.body));
      throw Exception("UNAUTHORIZED");
    }
  }

  Future postData(data, apiUrl) async {
    var fullUrl = _baseUrl + apiUrl;
    Uri fullURL = Uri.parse(fullUrl);

    final token = await authService().getToken();
    await http.post(
      fullURL,
      headers: _setHeadersToken(token),
      body: jsonEncode(data),
    );
  }

  // ini bise pake postData tok, drpd buat kelas masing-masing
  Future createCommunity(String name, String desc) async {
    var url = "private/community";

    Map data = {
      "community_name": name,
      "description": desc,
      "announcement_group_id": null,
    };

    return await auth(data, url);
  }

  Future<List<dynamic>> getCommunity() async {
    var url = _baseUrl + "private/community";
    final token = await authService().getToken();
    var response = await http.get(
      Uri.parse(url),
      headers: await _setHeadersToken(token),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load community");
    }
  }

  Future deleteCommunity(String id) async {
    var url = _baseUrl + "private/community/$id";
    final token = await authService().getToken();

    return await http.delete(
      Uri.parse(url),
      headers: await _setHeadersToken(token),
    );
  }

  Future updateCommunity(String id, String name, String desc) async {
    var url = _baseUrl + "private/community/$id";
    final token = await authService().getToken();
    Map data = {"community_name": name, "description": desc};
    return await http.put(
      Uri.parse(url),
      headers: await _setHeadersToken(token),
      body: jsonEncode(data),
    );
  }
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
