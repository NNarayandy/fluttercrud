import 'package:flutter/material.dart';
import 'package:gudangux/config/api.dart';
import 'package:gudangux/models/warehouse.dart';
import 'package:gudangux/pages/guest/guest_home_screen.dart';

class WarehouseListScreenGuest extends StatefulWidget {
  @override
  _WarehouseListScreenGuestState createState() => _WarehouseListScreenGuestState();
}

class _WarehouseListScreenGuestState extends State<WarehouseListScreenGuest> {
  late Future<List<Warehouse>> _warehousesFuture;

  @override
  void initState() {
    super.initState();
    _warehousesFuture = _fetchWarehouses();
  }

  Future<List<Warehouse>> _fetchWarehouses() async {
    try {
      final response = await Api.readWarehouse(); // Memanggil API dari api.dart
      List<Warehouse> warehouses = (response['data'] as List)
          .map((warehouse) => Warehouse.fromJson(warehouse))
          .toList();
      return warehouses;
    } catch (e) {
      throw Exception('Failed to load warehouses: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => GuestHomeScreen()),
            );
          },
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: const Color.fromARGB(225, 130, 172, 225),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(225, 130, 172, 225),
        ),
        child: Center(
          child: Container(
            width: 500,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Warehouse Guest',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Expanded(
                  child: FutureBuilder<List<Warehouse>>(
                    future: _warehousesFuture,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<Warehouse> warehouses = snapshot.data!;
                        return ListView.separated(
                          itemCount: warehouses.length,
                          separatorBuilder: (context, index) => Divider(
                            color: Colors.grey,
                            thickness: 1,
                          ),
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}