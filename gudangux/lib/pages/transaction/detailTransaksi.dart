import 'package:flutter/material.dart';
import 'package:gudangux/config/api.dart';
import 'package:gudangux/models/transaction.dart';
import 'package:gudangux/pages/transaction/UpdateTransaksi.dart';

class Detailtransaksi extends StatefulWidget {
  final int transactionId;

  Detailtransaksi({required this.transactionId});

  @override
  _DetailtransaksiState createState() => _DetailtransaksiState();
}

class _DetailtransaksiState extends State<Detailtransaksi> {
  late Future<Transaction> _transactionFuture;

  @override
  void initState() {
    super.initState();
    _transactionFuture = _fetchTransactionDetails(widget.transactionId);
  }

  Future<Transaction> _fetchTransactionDetails(int id) async {
    try {
      final response = await Api.detailTransaksi(id);
      if (response['success']) {
        return Transaction.fromJson(response['data']);
      } else {
        throw Exception(response['message']);
      }
    } catch (e) {
      throw Exception('Failed to fetch transaction: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction Detail'),
      ),
      body: FutureBuilder<Transaction>(
        future: _transactionFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            Transaction transaction = snapshot.data!;
            return Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Transaction #${transaction.id}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text('Item ID: ${transaction.itemId}'),
                  SizedBox(height: 10),
                  Text('Quantity: ${transaction.quantity}'),
                  SizedBox(height: 10),
                  Text('Type: ${transaction.type}'),
                  SizedBox(height: 10),
                  Text('Date: ${transaction.date}'),
                ],
              ),
            );
          }
          return Center(child: Text('No data found'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Updatetransaksi(transactionId: widget.transactionId),
            ),
          );
        },
        child: Icon(Icons.edit),
      ),
    );
  }
}
