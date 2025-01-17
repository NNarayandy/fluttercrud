import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:gudangux/models/admin.dart';

class AdminService {
  static const String baseUrl = 'http://localhost/gudangdb/backend/api/admin';

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

  static Future<Admin> getAdminProfile(int adminId) async {
    final response = await http.get(Uri.parse('$baseUrl/profile.php?id=$adminId'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['success']) {
        return Admin.fromJson(data['data']);
      } else {
        throw Exception(data['message']);
      }
    } else {
      throw Exception('Failed to get admin profile');
    }
  }
}