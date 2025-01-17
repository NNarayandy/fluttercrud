import 'package:flutter/material.dart';
import 'package:gudangux/config/api.dart';
import 'package:gudangux/pages/admin/DashboardAdmin.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPagState createState() => _LoginPagState();
}

class _LoginPagState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() async {
  String username = _usernameController.text;
  String password = _passwordController.text;

  try {
    // Memanggil fungsi login dari api.dart
    final response = await Api.login(username, password);

    if (response['success']) {
      int adminId = int.parse(response['admin_id']);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => AdminHomeScreen(adminId: adminId),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Login Failed'),
          content: Text(response['message']),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  } catch (e) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text('An error occurred while logging in.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}