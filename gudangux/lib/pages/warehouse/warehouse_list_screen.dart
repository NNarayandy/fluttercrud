import 'package:flutter/material.dart';
import 'package:gudangux/config/api.dart';
import 'package:gudangux/pages/admin/DashboardAdmin.dart';
import 'package:gudangux/pages/warehouse/warehouse_add_screen.dart';

class WarehouseListScreen extends StatefulWidget {
  @override
  _WarehouseListScreenState createState() => _WarehouseListScreenState();
}

class _WarehouseListScreenState extends State<WarehouseListScreen> {
  late Future<List<dynamic>> _warehousesFuture;

  @override
  void initState() {
    super.initState();
    _warehousesFuture = _fetchWarehouses();
  }

  Future<List<dynamic>> _fetchWarehouses() async {
    try {
      final response = await Api.readWarehouse();
      if (response['success']) {
        return response['data'];
      } else {
        throw Exception(response['message'] ?? 'Failed to fetch warehouses');
      }
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }

  Future<void> _deleteWarehouse(int warehouseId) async {
  try {
  final response = await Api.deleteWarehouse(warehouseId);
  print('Response status: ${response['success']}');
  print('Response message: ${response['message']}');

  if (response['success']) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Warehouse deleted successfully')),
    );
    setState(() {
      _warehousesFuture = _fetchWarehouses();
    });
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(response['message'] ?? 'Failed to delete warehouse')),
    );
  }
} catch (e) {
  print('Error occurred: $e');
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('An error occurred: $e')),
  );
}
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(225, 130, 172, 225),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(225, 130, 172, 225),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AdminHomeScreen(adminId: 1)), // Replace 1 with the actual adminId
            );
          },
        ),
      ),
      body: Center(
        child: Container(
          width: 400,
          height: 400,
          margin: EdgeInsets.all(16.0),
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10.0,
                spreadRadius: 2.0,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              Center(
                child: Text(
                  'Warehouses',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 2, 130, 227),
                  ),
                ),
              ),
              Divider(color: Colors.grey, thickness: 1),
              SizedBox(height: 16.0),
              Expanded(
                child: FutureBuilder<List<dynamic>>(
                  future: _warehousesFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text('No warehouses found'));
                    } else {
                      List<dynamic> warehouses = snapshot.data!;
                      return ListView.separated(
                        itemCount: warehouses.length,
                        separatorBuilder: (context, index) => Divider(
                          color: Colors.grey,
                          thickness: 1,
                        ),
                        itemBuilder: (context, index) {
                          final warehouse = warehouses[index];
                          return ListTile(
                            title: Text(warehouse['name']),
                            subtitle: Text(warehouse['location']),
                            trailing: IconButton(
                              icon: Icon(Icons.delete, color: const Color.fromARGB(255, 0, 0, 0)),
                              onPressed: () {
                                final warehouseId = int.parse(warehouse['id'].toString());
                                _showDeleteConfirmation(warehouseId);
                              },
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => WarehouseAddScreen()),
          );
        },
        backgroundColor: const Color.fromARGB(255, 2, 130, 227),
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  void _showDeleteConfirmation(int warehouseId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Warehouse'),
          content: Text('Are you sure you want to delete this warehouse?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _deleteWarehouse(warehouseId);
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}