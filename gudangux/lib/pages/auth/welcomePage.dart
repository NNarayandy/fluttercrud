import 'package:flutter/material.dart';
import 'package:gudangux/pages/guest/guest_home_screen.dart';
import 'package:gudangux/pages/auth/loginPage.dart';

class Welcomepage extends StatelessWidget {
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
                  MaterialPageRoute(builder: (context) => LoginPage()),
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