import 'package:http/http.dart' as http;

class ApiServices {
  static const String baseUrl = "https://localhost:8080";

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

  static Future<void> createUser(String name, String email) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/users'),
        body: {'name': name, 'email': email},
      );
      if (response.statusCode == 201) {
        print('User created successfully');
      } else {
        print('Failed to create user: ${response.statusCode}');
      }
    } catch (e) {
      print('Error creating user: $e');
    }
  }
}
