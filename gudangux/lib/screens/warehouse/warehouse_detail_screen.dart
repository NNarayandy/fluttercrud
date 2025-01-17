import 'package:flutter/material.dart';
import 'package:gudangux/models/warehouse.dart';
import 'package:gudangux/screens/warehouse/warehouse_edit_screen.dart';
import 'package:gudangux/services/warehouse_service.dart';

class WarehouseDetailScreen extends StatefulWidget {
  final int warehouseId;

  WarehouseDetailScreen({required this.warehouseId});

  @override
  _WarehouseDetailScreenState createState() => _WarehouseDetailScreenState();
}

class _WarehouseDetailScreenState extends State<WarehouseDetailScreen> {
  late Future<Warehouse> _warehouseFuture;

  @override
  void initState() {
    super.initState();
    _warehouseFuture = WarehouseService.getWarehouseById(widget.warehouseId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Warehouse Detail'),
      ),
      body: FutureBuilder<Warehouse>(
        future: _warehouseFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Warehouse warehouse = snapshot.data!;
            return Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    warehouse.name,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text('Location: ${warehouse.location}'),
                ],
              ),
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
            MaterialPageRoute(
              builder: (context) => WarehouseEditScreen(warehouseId: widget.warehouseId),
            ),
          );
        },
        child: Icon(Icons.edit),
      ),
    );
  }
}