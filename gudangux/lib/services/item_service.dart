import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:gudangux/models/item.dart';

class ItemService {
  static const String baseUrl = 'http://localhost/gudangdb/backend/api/item';

  static Future<List<Item>> getItems() async {
    final response = await http.get(Uri.parse('$baseUrl/read.php'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'] as List<dynamic>;
      return data.map((json) => Item.fromJson(json)).toList();
    } else {
      throw Exception('Failed to get items');
    }
  }

  static Future<Item> getItemById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/read.php?id=$id'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'];
      return Item.fromJson(data);
    } else {
      throw Exception('Failed to get item');
    }
  }

  static Future<Map<String, dynamic>> createItem(String name, String description, int quantity, int warehouseId) async {
    final body = {
      'name': name,
      'description': description,
      'quantity': quantity.toString(),
      'warehouse_id': warehouseId.toString(),
    };

    final response = await http.post(
      Uri.parse('$baseUrl/create.php'),
      body: body,
    );

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Failed to create item. Status code: ${response.statusCode}');
    }
  }

  static Future<Map<String, dynamic>> updateItem(int id, String name, String description, int quantity, int warehouseId) async {
    final body = {
      'id': id.toString(),
      'name': name,
      'description': description,
      'quantity': quantity.toString(),
      'warehouse_id': warehouseId.toString(),
    };

    final response = await http.post(
      Uri.parse('$baseUrl/update.php'),
      body: body,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Failed to update item. Status code: ${response.statusCode}');
    }
  }

  static Future<Map<String, dynamic>> deleteItem(int id) async {
    final response = await http.post(
      Uri.parse('$baseUrl/delete.php'),
      body: {'id': id.toString()},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Failed to delete item. Status code: ${response.statusCode}');
    }
  }
}