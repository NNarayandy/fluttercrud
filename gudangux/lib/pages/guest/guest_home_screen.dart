import 'package:flutter/material.dart';
import 'package:gudangux/pages/guest/item_list_screen_guest.dart';
import 'package:gudangux/pages/guest/warehouse_list_screen_guest.dart';


class GuestHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Guest Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>ItemListScreenGuest()),
                );
              },
              child: Text('View Items'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WarehouseListScreenGuest()),
                );
              },
              child: Text('View Warehouses'),
            ),
          ],
        ),
      ),
    );
  }
}