import 'package:flutter/material.dart';
import 'package:gudangux/models/warehouse.dart';
import 'package:gudangux/services/warehouse_service.dart';

class WarehouseListScreenGuest extends StatefulWidget {
  @override
  _WarehouseListScreenGuestState createState() => _WarehouseListScreenGuestState();
}

class _WarehouseListScreenGuestState extends State<WarehouseListScreenGuest> {
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
        title: Text('Warehouses guest'),
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
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}