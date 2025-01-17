import 'package:flutter/material.dart';
import 'package:gudangux/models/transaction.dart';
import 'package:gudangux/pages/transaction/transaction_edit_screen.dart';
import 'package:gudangux/services/transaction_service.dart';

class TransactionDetailScreen extends StatefulWidget {
  final int transactionId;

  TransactionDetailScreen({required this.transactionId});

  @override
  _TransactionDetailScreenState createState() => _TransactionDetailScreenState();
}

class _TransactionDetailScreenState extends State<TransactionDetailScreen> {
  late Future<Transaction> _transactionFuture;

  @override
  void initState() {
    super.initState();
    _transactionFuture = TransactionService.getTransactionById(widget.transactionId);
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
          if (snapshot.hasData) {
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
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TransactionEditScreen(transactionId: widget.transactionId),
            ),
          );
        },
        child: Icon(Icons.edit),
      ),
    );
  }
}