import 'package:flutter/material.dart';
import 'package:gudangux/models/warehouse.dart';
import 'package:gudangux/screens/warehouse/warehouse_add_screen.dart';
import 'package:gudangux/screens/warehouse/warehouse_detail_screen.dart';
import 'package:gudangux/services/warehouse_service.dart';

class WarehouseListScreen extends StatefulWidget {
  @override
  _WarehouseListScreenState createState() => _WarehouseListScreenState();
}

class _WarehouseListScreenState extends State<WarehouseListScreen> {
  late Future<List<Warehouse>> _warehousesFuture;

  @override
  void initState() {
    super.initState();
    _warehousesFuture = WarehouseService.getWarehouses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Warehouses'),
      ),
      body: FutureBuilder<List<Warehouse>>(
        future: _warehousesFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Warehouse> warehouses = snapshot.data!;
            return ListView.builder(
              itemCount: warehouses.length,
              itemBuilder: (context, index) {
                Warehouse warehouse = warehouses[index];
                return ListTile(
                  title: Text(warehouse.name),
                  subtitle: Text(warehouse.location),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WarehouseDetailScreen(warehouseId: warehouse.id),
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
            MaterialPageRoute(builder: (context) => WarehouseAddScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}