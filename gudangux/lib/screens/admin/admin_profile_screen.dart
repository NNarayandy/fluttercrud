import 'package:flutter/material.dart';
import 'package:gudangux/models/admin.dart';
import 'package:gudangux/services/admin_service.dart';

class AdminProfileScreen extends StatefulWidget {
  final int adminId;

  AdminProfileScreen({required this.adminId});

  @override
  _AdminProfileScreenState createState() => _AdminProfileScreenState();
}

class _AdminProfileScreenState extends State<AdminProfileScreen> {
  late Future<Admin> _adminFuture;

  @override
  void initState() {
    super.initState();
    _adminFuture = AdminService.getAdminProfile(widget.adminId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Profile'),
      ),
      body: FutureBuilder<Admin>(
        future: _adminFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            Admin admin = snapshot.data!;
            return Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Username: ${admin.username}',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to edit profile screen
                    },
                    child: Text('Edit Profile'),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}