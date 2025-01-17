import 'dart:convert';
import 'package:http/http.dart' as http;

class Api {
  static const String baseUrl = 'http://localhost/gudangdb/backend/api';

  static const String itemCreate = '$baseUrl/item/create.php';
  static const String itemDelete = '$baseUrl/item/delete.php';
  static const String item = '$baseUrl/item/create.php';
  static const String itemUrl = '$baseUrl/item/create.php';
  static const String itemUrl = '$baseUrl/item/create.php';


  static Future<Map<String, dynamic>> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login.php'),
      body: {'username': username, 'password': password},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Failed to login');
    }
  }
}