import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:gudangux/models/transaction.dart';

class TransactionService {
  static const String baseUrl = 'http://localhost/gudangdb/backend/api/transaction';

  static Future<List<Transaction>> getTransactions() async {
    final response = await http.get(Uri.parse('$baseUrl/read.php'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'] as List<dynamic>;
      return data.map((json) => Transaction.fromJson(json)).toList();
    } else {
      throw Exception('Failed to get transactions');
    }
  }

  static Future<Transaction> getTransactionById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/read_single.php?id=$id'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'];
      return Transaction.fromJson(data);
    } else {
      throw Exception('Failed to get transaction');
    }
  }

  static Future<bool> createTransaction(int itemId, int quantity, String type, String date) async {
    final response = await http.post(
      Uri.parse('$baseUrl/create.php'),
      body: {
        'item_id': itemId.toString(),
        'quantity': quantity.toString(),
        'type': type,
        'date': date,
      },
    );

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return data['success'];
    } else {
      throw Exception('Failed to create transaction');
    }
  }

  static Future<bool> updateTransaction(int id, int itemId, int quantity, String type, String date) async {
    final response = await http.put(
      Uri.parse('$baseUrl/update.php'),
      body: {
        'id': id.toString(),
        'item_id': itemId.toString(),
        'quantity': quantity.toString(),
        'type': type,
        'date': date,
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['success'];
    } else {
      throw Exception('Failed to update transaction');
    }
  }

  // Implement other CRUD methods (delete) here
}