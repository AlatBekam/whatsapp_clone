import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

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

  httpPOST({Map<String, dynamic>? data, required String apiUrl}) async {
    var fullUrl = _baseUrl + apiUrl;
    Uri fullURL = Uri.parse(fullUrl);

    return await http.post(
      fullURL,
      headers: _setHeadersToken(null),
      body: jsonEncode(data),
    );
  }

  httpPOSTWithToken({
    Map<String, dynamic>? data,
    required String apiUrl,
  }) async {
    var fullUrl = _baseUrl + apiUrl;
    Uri fullURL = Uri.parse(fullUrl);

    return await http.post(
      fullURL,
      headers: _setHeadersToken(await _token),
      body: jsonEncode(data),
    );
  }

  httpGET(String apiUrl) async {
    var fullUrl = _baseUrl + apiUrl;
    Uri fullURL = Uri.parse(fullUrl);

    return await http.get(fullURL, headers: _setHeadersToken(null));
  }

  httpGETWithToken(String apiUrl) async {
    var fullUrl = _baseUrl + apiUrl;
    Uri fullURL = Uri.parse(fullUrl);

    String? a = await AuthService().getToken();

    return await http.get(fullURL, headers: _setHeadersToken(await a));
  }

  httpPUT({Map<String, dynamic>? data, required String apiUrl}) async {
    var fullUrl = _baseUrl + apiUrl;
    Uri fullURL = Uri.parse(fullUrl);

    return await http.post(
      fullURL,
      headers: _setHeadersToken(null),
      body: jsonEncode(data),
    );
  }

    Future httpPUTWithToken({
      Map<String, dynamic>? data,
      required String apiUrl,
    }) async {
      var fullUrl = _baseUrl + apiUrl;
      Uri fullURL = Uri.parse(fullUrl);

      return await http.put(
        fullURL,
        headers: _setHeadersToken(await _token),
        body: jsonEncode(data),
      );
    }

  Future httpDELETEWithToken(String apiUrl) async {
    var fullUrl = _baseUrl + apiUrl;
    Uri fullURL = Uri.parse(fullUrl);

    return await http.delete(
      fullURL,
      headers: _setHeadersToken(await _token),
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

// class HttpServices {
//   Future<Map<String, String>> headers() async => {
//     'Authorization': 'Bearer ${await AuthService().getToken()}',
//     'Content-type': 'application/json',
//   };
//   static Future get(String url, {Map<String, dynamic>? data}) async {
//     var headers = await HttpServices().headers();
//     await http
//         .get(Uri.parse(ApiServices._baseUrl + url), headers: headers)
//         .then((response) {
//           if (response.statusCode == 200) {
//             var data = jsonDecode(response.body);
//             print("data Result: $data");
//             return data;
//           } else {
//             print("error: ${response.body}");
//           }
//           if (response.statusCode == 401) {
//             print("Unauth");
//             throw Exception(["Unauth"]);
//           }
//         });
//   }

//   static Future post(String url, {Map<String, dynamic>? data}) async {
//     var headers = await HttpServices().headers();
//     await http
//         .post(
//           Uri.parse(ApiServices._baseUrl + url),
//           headers: headers,
//           body: jsonEncode(Map.from(data ?? {})),
//         )
//         .then((response) {
//           print("response.body: ${response.body}");
//           print("response.statusCode: ${response.statusCode}");
//           if (response.statusCode.toString() == "200") {
//             var data = jsonDecode(response.body);
//             return data;
//           }
//           if (response.statusCode.toString() == "401") {
//             print("Unauth");
//             throw Exception(["Unauth"]);
//           }
//         });
//   }
// }
