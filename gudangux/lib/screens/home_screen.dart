import 'package:flutter/material.dart';
import 'package:gudangux/screens/guest/guest_home_screen.dart';
import 'package:gudangux/screens/admin/admin_login_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gudang App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdminLoginScreen()),
                );
              },
              child: Text('Admin Login'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GuestHomeScreen()),
                );
              },
              child: Text('Guest Mode'),
            ),
          ],
        ),
      ),
    );
  }
}