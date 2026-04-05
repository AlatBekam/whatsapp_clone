import 'dart:convert';

class HttpHandler {
  /// HANDLE RESPONSE (SUCCESS & ERROR)
  static dynamic handleResponse(response) {
    final statusCode = response.statusCode;

    // SUCCESS
    if (statusCode >= 200 && statusCode < 300) {
      if (response.body.isNotEmpty) {
        return jsonDecode(response.body); //StringToMap
      }
      return true;
    }

    // ERROR
    String message = "Terjadi kesalahan";

    try {
      final body = jsonDecode(response.body);
      message = body['message'] ?? body['error'] ??  message;
    } catch (_) {}

    switch (statusCode) {
      case 400: //request salah
        throw Exception(message);
      case 401: //belum terautentikasi atau token tidak valid
        throw Exception("Session expired, Please login again");
      case 404: //resource tidak ditemukan
        throw Exception("Data tidak ditemukan");
      case 409: //Request bentrok dengan data yang sudah ada
        throw Exception(message);
      case 500: //kesalahan server
        throw Exception("Server error");
      default:
        throw Exception(message);
    }
  }
}