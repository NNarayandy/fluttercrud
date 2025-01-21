import 'dart:convert';
import 'package:gudangux/models/item.dart';
import 'package:http/http.dart' as http;

class Api {
  static const String baseUrl = 'http://localhost/gudangdb/api';

  static const String adminLogin = '$baseUrl/admin/login.php';

  static const String itemCreate = '$baseUrl/item/createItem.php';
  static const String itemDelete = '$baseUrl/item/deleteItem.php';
  static const String getDataItem = '$baseUrl/item/getDataItem.php';
  static const String itemDetail = '$baseUrl/item/itemDetail.php';
  static const String updateItem = '$baseUrl/item/Updateitem.php';

  static const String transactionCreate = '$baseUrl/transaction/create.php';
  static const String transactionDelete = '$baseUrl/transaction/delete.php';
  static const String transactionRead = '$baseUrl/transaction/read.php';
  static const String updatetransaksi ='$baseUrl/transaction/updateTransaksi.php';
  static const String detailtransaksi ='$baseUrl/transaction/detailTransaksi.php';

  static const String warehouseCreate = '$baseUrl/warehouse/createWare.php';
  static const String warehouseDelete = '$baseUrl/warehouse/deleteWare.php';
  static const String warehouseRead = '$baseUrl//warehouse/readWare.php';
 

  static Future<Map<String, dynamic>> login(
      String username, String password) async {
    final response = await http.post(
      Uri.parse(adminLogin),
      body: {'username': username, 'password': password},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Failed to login');
    }
  }

  // Founction Item
  static Future<Map<String, dynamic>> createItem(
      String name, String description, int quantity, int warehouseId) async {
    final body = {
      'name': name,
      'description': description,
      'quantity': quantity.toString(),
      'warehouse_id': warehouseId.toString(),
    };

    final response = await http.post(
      Uri.parse(itemCreate),
      body: body,
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      if (data['success'] == true) {
        return data;
      } else {
        throw Exception('Failed to create item: ${data['message']}');
      }
    } else {
      throw Exception(
          'Failed to create item. Status code: ${response.statusCode}');
    }
  }

  static Future<Map<String, dynamic>> updateItemFunction(
    int id,
    String name,
    String description,
    int quantity,
    int warehouseId,
  ) async {
    final body = {
      'id': id.toString(), // Kirim ID sebagai bagian dari request
      'name': name,
      'description':
          description.isNotEmpty ? description : '', // Default jika kosong
      'quantity': quantity.toString(),
      'warehouse_id': warehouseId.toString(),
    };

    print('Request body: $body'); // Debug log untuk memeriksa isi body

    try {
      final response = await http.post(
        Uri.parse(updateItem), // Pastikan URL sesuai
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body), // Encode body ke JSON
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body); // Parsing response ke Map
      } else {
        throw Exception(
            'Failed to update item. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }

  static Future<dynamic> deleteItem(int id) async {
    try {
      final response = await http.post(
        Uri.parse(itemDelete),
        body: {'id': id.toString()},
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data;
      } else {
        throw Exception(
            'Failed to delete item. Status code: ${response.statusCode}, Body: ${response.body}');
      }
    } catch (e) {
      print('Error in deleteItem: $e');
      rethrow;
    }
  }

  static Future<List<Item>> getDataItemFunction() async {
    final response = await http.get(Uri.parse(getDataItem));

    if (response.statusCode == 200) {
      // Parsing JSON ke dalam list
      final List<dynamic> data = jsonDecode(response.body);

      // Validasi format respons
      return data
          .map((item) => Item.fromJson(item as Map<String, dynamic>))
          .toList();
        } else {
      throw Exception(
          'Failed to read item. Status code: ${response.statusCode}');
    }
  }

  static Future<Map<String, dynamic>> detailItem(int id) async {
    try {
      final response = await http.post(
        Uri.parse(itemDetail),
        body: {'id': id.toString()},
      );

      print('Response: ${response.body}'); // Debug log respons

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['success'] == true) {
          return data['data'];
        } else {
          throw Exception(data['message'] ?? 'Unknown error occurred');
        }
      } else {
        throw Exception(
            'Failed to fetch item. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e'); // Debug log error
      throw Exception('Error fetching item details: $e');
    }
  }

  // Function Transaction
  static Future<Map<String, dynamic>> createTransaction(
      int itemId, int quantity, String type) async {
    final body = {
      'item_id': itemId.toString(),
      'quantity': quantity.toString(),
      'type': type,
    };

    final response = await http.post(
      Uri.parse(transactionCreate),
      body: body,
    );

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception(
          'Failed to create transaction. Status code: ${response.statusCode}');
    }
  }

  static Future<Map<String, dynamic>> updateTransaction(
      int id, int itemId, int quantity, String type) async {
    final body = {
      'id': id.toString(),
      'item_id': itemId.toString(),
      'quantity': quantity.toString(),
      'type': type,
    };

    final response = await http.post(
      Uri.parse(updatetransaksi),
      body: body,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception(
          'Failed to update transaction. Status code: ${response.statusCode}');
    }
  }

  static Future<Map<String, dynamic>> deleteTransaction(int id) async {
    final response = await http.post(
      Uri.parse(transactionDelete),
      body: {'id': id.toString()},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception(
          'Failed to delete transaction. Status code: ${response.statusCode}');
    }
  }

  static Future<Map<String, dynamic>> readTransaction() async {
    try {
      final response = await http.get(Uri.parse(transactionRead));

      // Logging untuk debug
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data;
      } else {
        throw Exception(
            'Failed to read transaction. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during transaction fetch: $e');
      throw Exception('Failed to fetch transaction: $e');
    }
  }

  static Future<Map<String, dynamic>> detailTransaksi(int id) async {
    final response = await http.post(
      Uri.parse(detailtransaksi),
      body: {'id': id.toString()},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception(
          'Failed to read transaction. Status code: ${response.statusCode}');
    }
  }

  // Function Warehouse
  static Future<Map<String, dynamic>> createWarehouse(
      String name, String location) async {
    final body = jsonEncode({
      'name': name,
      'location': location,
    });

    final response = await http.post(
      Uri.parse(warehouseCreate), // Pastikan URL ini benar
      headers: {'Content-Type': 'application/json'}, // Set Content-Type
      body: body,
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
          'Failed to create warehouse. Status code: ${response.statusCode}');
    }
  }

  static Future<Map<String, dynamic>> deleteWarehouse(int id) async {
    final response = await http.delete(
      Uri.parse('$warehouseDelete/$id'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception(
          'Failed to delete warehouse. Status code: ${response.statusCode}');
    }
  }



  static Future<Map<String, dynamic>> readWarehouse() async {
    try {
      final response = await http.get(Uri.parse(warehouseRead));

      // Debug log untuk respons mentah
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data;
      } else {
        throw Exception(
            'Failed to read warehouse. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Error during warehouse fetch: $e');
    }
  }
}
