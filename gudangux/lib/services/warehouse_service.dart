// warehouse_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:gudangux/models/warehouse.dart';

class WarehouseService {
  static const String baseUrl = 'http://localhost/gudangdb/backend/api/warehouse';

  static Future<List<Warehouse>> getWarehouses() async {
    final response = await http.get(Uri.parse('$baseUrl/read.php'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'] as List<dynamic>;
      return data.map((json) => Warehouse.fromJson(json)).toList();
    } else {
      throw Exception('Failed to get warehouses');
    }
  }

  static Future<Warehouse> getWarehouseById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/read_single.php?id=$id'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'];
      return Warehouse.fromJson(data);
    } else {
      throw Exception('Failed to get warehouse');
    }
  }

  static Future<bool> createWarehouse(String name, String location) async {
    final response = await http.post(
      Uri.parse('$baseUrl/create.php'),
      body: {
        'name': name,
        'location': location,
      },
    );

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return data['success'];
    } else {
      throw Exception('Failed to create warehouse');
    }
  }

  static Future<bool> updateWarehouse(int id, String name, String location) async {
    final response = await http.put(
      Uri.parse('$baseUrl/update.php'),
      body: {
        'id': id.toString(),
        'name': name,
        'location': location,
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['success'];
    } else {
      throw Exception('Failed to update warehouse');
    }
  }

  // Implement other CRUD methods (delete) here
}