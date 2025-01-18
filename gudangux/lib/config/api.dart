import 'dart:convert';
import 'package:gudangux/models/item.dart';
import 'package:http/http.dart' as http;

class Api {
  static const String baseUrl = 'http://localhost/gudangdb/api';

  static const String adminLogin = '$baseUrl/admin/login.php';

  static const String itemCreate = '$baseUrl/item/create.php';
  static const String itemDelete = '$baseUrl/item/deleteItem.php';
  static const String getDataItem = '$baseUrl/item/getDataItem.php';
  static const String itemDetail = '$baseUrl/item/itemDetail.php';
  static const String updateItem = '$baseUrl/item/Updateitem.php';

  static const String transactionCreate = '$baseUrl/transaction/create.php';
  static const String transactionDelete = '$baseUrl/transaction/delete.php';
  static const String transactionRead = '$baseUrl/transaction/read.php';
  static const String updatetransaksi = '$baseUrl/transaction/updateTransaksi.php';
  static const String detailtransaksi = '$baseUrl/transaction/detailTransaksi.php';

  static const String warehouseCreate = '$baseUrl/warehouse/create.php';
  static const String warehouseDelete = '$baseUrl/warehouse/delete.php';
  static const String warehouseRead = '$baseUrl/warehouse/read.php';
  static const String warehouseUpdate = '$baseUrl/warehouse/updateWarehouse.php';
  static const String warehouseDetail = '$baseUrl/warehouse/warehouseDetail.php';

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

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception(
          'Failed to create item. Status code: ${response.statusCode}');
    }
  }

  static Future<Map<String, dynamic>> updateItemFunction(int id, String name,
      String description, int quantity, int warehouseId) async {
    final body = {
      'id': id.toString(),
      'name': name,
      'description': description,
      'quantity': quantity.toString(),
      'warehouse_id': warehouseId.toString(),
    };

    final response = await http.post(
      Uri.parse(updateItem),
      body: body,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception(
          'Failed to update item. Status code: ${response.statusCode}');
    }
  }

  static Future<Map<String, dynamic>> deleteItem(int id) async {
    final response = await http.post(
      Uri.parse(itemDelete),
      body: {'id': id.toString()},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception(
          'Failed to delete item. Status code: ${response.statusCode}');
    }
  }

  static Future<List<Item>> getDataItemFunction() async {
    final response = await http.get(Uri.parse(getDataItem));

    if (response.statusCode == 200) {
      // Mengonversi JSON response ke List<Item>
      List<dynamic> data = jsonDecode(response.body);
      return data.map((itemData) => Item.fromJson(itemData)).toList();
    } else {
      throw Exception(
          'Failed to read item. Status code: ${response.statusCode}');
    }
  }

  static Future<Map<String, dynamic>> detailItem(int id) async {
    final response = await http.post(
      Uri.parse(itemDetail),
      body: {'id': id.toString()},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception(
          'Failed to read item. Status code: ${response.statusCode}');
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
    final response = await http.get(Uri.parse(transactionRead));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception(
          'Failed to read transaction. Status code: ${response.statusCode}');
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
    final body = {
      'name': name,
      'location': location,
    };

    final response = await http.post(
      Uri.parse(warehouseCreate),
      body: body,
    );

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception(
          'Failed to create warehouse. Status code: ${response.statusCode}');
    }
  }

  static Future<Map<String, dynamic>> updateWarehouse(
      int id, String name, String location) async {
    final body = {
      'id': id.toString(),
      'name': name,
      'location': location,
    };

    final response = await http.post(
      Uri.parse(warehouseUpdate),
      body: body,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception(
          'Failed to update warehouse. Status code: ${response.statusCode}');
    }
  }

  static Future<Map<String, dynamic>> deleteWarehouse(int id) async {
    final response = await http.post(
      Uri.parse(warehouseDelete),
      body: {'id': id.toString()},
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
    final response = await http.get(Uri.parse(warehouseRead));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception(
          'Failed to read warehouse. Status code: ${response.statusCode}');
    }
  }

  static Future<Map<String, dynamic>> detailWarehouse(int id) async {
    final response = await http.post(
      Uri.parse(warehouseDetail),
      body: {'id': id.toString()},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception(
          'Failed to read warehouse. Status code: ${response.statusCode}');
    }
  }
}
