import 'package:flutter/material.dart';
import 'package:gudangux/pages/auth/welcomePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gudang App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Welcomepage(),
    );
  }
}