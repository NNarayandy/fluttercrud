import 'package:flutter/material.dart';
import 'package:gudangux/config/api.dart';
import 'package:gudangux/pages/warehouse/warehouse_add_screen.dart';
import 'package:gudangux/pages/warehouse/warehouse_detail_screen.dart';

class WarehouseListScreen extends StatefulWidget {
  @override
  _WarehouseListScreenState createState() => _WarehouseListScreenState();
}

class _WarehouseListScreenState extends State<WarehouseListScreen> {
  late Future<List<dynamic>> _warehousesFuture; // Menggunakan List<dynamic> agar fleksibel

  @override
  void initState() {
    super.initState();
    _warehousesFuture = _fetchWarehouses(); // Panggil fungsi pembungkus API
  }

  Future<List<dynamic>> _fetchWarehouses() async {
    try {
      final response = await Api.readWarehouse(); // Panggil API
      if (response['success']) {
        return response['data']; // Pastikan API mengembalikan key 'data'
      } else {
        throw Exception(response['message'] ?? 'Failed to fetch warehouses');
      }
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Warehouses'),
      ),
      body: FutureBuilder<List<dynamic>>(
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
            return ListView.builder(
              itemCount: warehouses.length,
              itemBuilder: (context, index) {
                final warehouse = warehouses[index];
                return ListTile(
                  title: Text(warehouse['name']),
                  subtitle: Text(warehouse['location']),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            WarehouseDetailScreen(warehouseId: warehouse['id']),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => WarehouseAddScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
