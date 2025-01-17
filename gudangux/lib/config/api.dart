import 'dart:convert';
import 'package:http/http.dart' as http;

class Api {
  static const String baseUrl = 'http://192.168.1.9/gudangdb/backend/api';

  static const String adminLogin = '$baseUrl/admin/login.php';

  static const String itemCreate = '$baseUrl/item/create.php';
  static const String itemDelete = '$baseUrl/item/delete.php';
  static const String itemRead = '$baseUrl/item/read.php';
  static const String itemUpdate = '$baseUrl/item/update.php';

  static const String transactionCreate = '$baseUrl/transaction/create.php';
  static const String transactionDelete = '$baseUrl/transaction/delete.php';
  static const String transactionRead = '$baseUrl/transaction/read.php';
  static const String transactionUpdate = '$baseUrl/transaction/update.php';

  static const String warehouseCreate = '$baseUrl/warehouse/create.php';
  static const String warehouseDelete = '$baseUrl/warehouse/delete.php';
  static const String warehouseRead = '$baseUrl/warehouse/read.php';
  static const String warehouseUpdate = '$baseUrl/warehouse/update.php';

  static const String adminController = '$baseUrl/controllers/AdminController.php';
  static const String itemController = '$baseUrl/controllers/ItemController.php';
  static const String transactionController = '$baseUrl/controllers/TransactionController.php';
  static const String warehouseController = '$baseUrl/controllers/WarehouseController.php';

  static const String adminModel = '$baseUrl/models/Admin.php';
  static const String itemModel = '$baseUrl/models/Item.php';
  static const String transactionModel = '$baseUrl/models/Transaction.php';
  static const String warehouseModel = '$baseUrl/models/Warehouse.php';

  static Future<Map<String, dynamic>> login(String username, String password) async {
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
  static Future<Map<String, dynamic>> createItem(String name, String description, int quantity, int warehouseId) async {
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
      Uri.parse(itemUpdate),
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
      Uri.parse(itemDelete),
      body: {'id': id.toString()},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Failed to delete item. Status code: ${response.statusCode}');
    }
  }

  static Future<Map<String, dynamic>> readItem() async {
    final response = await http.get(
      Uri.parse(itemRead));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Failed to read item. Status code: ${response.statusCode}');
    }
  }

  // Function Transaction
  static Future<Map<String, dynamic>> createTransaction(int itemId, int quantity, String type) async {
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
      throw Exception('Failed to create transaction. Status code: ${response.statusCode}');
    }
  }

  static Future<Map<String, dynamic>> updateTransaction(int id, int itemId, int quantity, String type) async {
    final body = {
      'id': id.toString(),
      'item_id': itemId.toString(),
      'quantity': quantity.toString(),
      'type': type,
    };

    final response = await http.post(
      Uri.parse(transactionUpdate),
      body: body,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Failed to update transaction. Status code: ${response.statusCode}');
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
      throw Exception('Failed to delete transaction. Status code: ${response.statusCode}');
    }
  }

  static Future<Map<String, dynamic>> readTransaction() async {
    final response = await http.get(
      Uri.parse(transactionRead));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Failed to read transaction. Status code: ${response.statusCode}');
    }
  }

  // Function Warehouse
  static Future<Map<String, dynamic>> createWarehouse(String name, String location) async {
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
      throw Exception('Failed to create warehouse. Status code: ${response.statusCode}');
    }
  }

  static Future<Map<String, dynamic>> updateWarehouse(int id, String name, String location) async {
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
      throw Exception('Failed to update warehouse. Status code: ${response.statusCode}');
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
      throw Exception('Failed to delete warehouse. Status code: ${response.statusCode}');
    }
  }

  static Future<Map<String, dynamic>> readWarehouse() async {
    final response = await http.get(Uri.parse(warehouseRead));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Failed to read warehouse. Status code: ${response.statusCode}');
    }
  }

  // Function controller
  static Future<Map<String, dynamic>> adminControllerFunction(String action, Map<String, dynamic> data) async {
    final body = {
      'action': action,
      'data': jsonEncode(data),
    };

    final response = await http.post(
      Uri.parse(adminController),
      body: body,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Failed to execute admin controller. Status code: ${response.statusCode}');
    }
  }

  static Future<Map<String, dynamic>> itemControllerFunction(String action, Map<String, dynamic> data) async {
    final body = {
      'action': action,
      'data': jsonEncode(data),
    };

    final response = await http.post(
      Uri.parse(itemController),
      body: body,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Failed to execute item controller. Status code: ${response.statusCode}');
    }
  }

  static Future<Map<String, dynamic>> transactionControllerFunction(String action, Map<String, dynamic> data) async {
    final body = {
      'action': action,
      'data': jsonEncode(data),
    };

    final response = await http.post(
      Uri.parse(transactionController),
      body: body,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Failed to execute transaction controller. Status code: ${response.statusCode}');
    }
  }

  static Future<Map<String, dynamic>> warehouseControllerFunction(String action, Map<String, dynamic> data) async {
    final body = {
      'action': action,
      'data': jsonEncode(data),
    };

    final response = await http.post(
      Uri.parse(warehouseController),
      body: body,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Failed to execute warehouse controller. Status code: ${response.statusCode}');
    }
  }

  // Function model
  static Future<Map<String, dynamic>> adminModelFunction(String action, Map<String, dynamic> data) async {
    final body = {
      'action': action,
      'data': jsonEncode(data),
    };

    final response = await http.post(
      Uri.parse(adminModel),
      body: body,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Failed to execute admin model. Status code: ${response.statusCode}');
    }
  }

  static Future<Map<String, dynamic>> itemModelFunction(String action, Map<String, dynamic> data) async {
    final body = {
      'action': action,
      'data': jsonEncode(data),
    };

    final response = await http.post(
      Uri.parse(itemModel),
      body: body,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Failed to execute item model. Status code: ${response.statusCode}');
    }
  }

  static Future<Map<String, dynamic>> transactionModelFunction(String action, Map<String, dynamic> data) async {
    final body = {
      'action': action,
      'data': jsonEncode(data),
    };

    final response = await http.post(
      Uri.parse(transactionModel),
      body: body,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Failed to execute transaction model. Status code: ${response.statusCode}');
    }
  }

  static Future<Map<String, dynamic>> warehouseModelFunction(String action, Map<String, dynamic> data) async {
    final body = {
      'action': action,
      'data': jsonEncode(data),
    };

    final response = await http.post(
      Uri.parse(warehouseModel),
      body: body,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Failed to execute warehouse model. Status code: ${response.statusCode}');
    }
  }
}