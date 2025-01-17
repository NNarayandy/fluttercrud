
import 'package:flutter/material.dart';
import 'package:gudangux/pages/item/item_list_screen.dart';
import 'package:gudangux/pages/transaction/transaction_list_screen.dart';
import 'package:gudangux/pages/warehouse/warehouse_list_screen.dart';



class AdminHomeScreen extends StatelessWidget {
  final int adminId;

  AdminHomeScreen({required this.adminId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome, Admin!'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ItemListScreen()),
                );
              },
              child: Text('Manage Items'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TransactionListScreen()),
                );
              },
              child: Text('Manage Transactions'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WarehouseListScreen()),
                );
              },
              child: Text('Manage Warehouses'),
            ),
          ],
        ),
      ),
    );
  }
}