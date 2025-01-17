import 'package:flutter/material.dart';
import 'package:gudangux/models/transaction.dart';
import 'package:gudangux/screens/transaction/transaction_add_screen.dart';
import 'package:gudangux/screens/transaction/transaction_detail_screen.dart';
import 'package:gudangux/services/transaction_service.dart';

class TransactionListScreen extends StatefulWidget {
  @override
  _TransactionListScreenState createState() => _TransactionListScreenState();
}

class _TransactionListScreenState extends State<TransactionListScreen> {
  late Future<List<Transaction>> _transactionsFuture;

  @override
  void initState() {
    super.initState();
    _transactionsFuture = TransactionService.getTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transactions'),
      ),
      body: FutureBuilder<List<Transaction>>(
        future: _transactionsFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Transaction> transactions = snapshot.data!;
            return ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                Transaction transaction = transactions[index];
                return ListTile(
                  title: Text('Transaction #${transaction.id}'),
                  subtitle: Text('Type: ${transaction.type}'),
                  trailing: Text('Quantity: ${transaction.quantity}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TransactionDetailScreen(transactionId: transaction.id),
                      ),
                    );
                  },
                );
              },
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
            MaterialPageRoute(builder: (context) => TransactionAddScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}