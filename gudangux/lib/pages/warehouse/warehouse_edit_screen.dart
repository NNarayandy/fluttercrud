import 'package:flutter/material.dart';
import 'package:gudangux/config/api.dart'; // Mengimpor API dari api.dart
import 'package:gudangux/models/warehouse.dart';

class WarehouseEditScreen extends StatefulWidget {
  final int warehouseId;

  WarehouseEditScreen({required this.warehouseId});

  @override
  _WarehouseEditScreenState createState() => _WarehouseEditScreenState();
}

class _WarehouseEditScreenState extends State<WarehouseEditScreen> {
  final _formKey = GlobalKey<FormState>();
  late Future<Warehouse> _warehouseFuture;
  late String _name;
  late String _location;

  @override
  void initState() {
    super.initState();
    // Ambil data warehouse yang akan diedit
    _warehouseFuture = _getWarehouseDetails();
  }

  Future<Warehouse> _getWarehouseDetails() async {
    // Panggil API untuk mendapatkan detail warehouse
    final data = await Api.detailWarehouse(widget.warehouseId);
    return Warehouse.fromJson(data); // Pastikan menggunakan model yang sesuai
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Panggil API updateWarehouse dari api.dart untuk mengupdate data warehouse
      Api.updateWarehouse(widget.warehouseId, _name, _location).then((response) {
        if (response['message'] == 'Warehouse updated successfully') {
          // Tampilkan pesan sukses dan kembali ke layar sebelumnya
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Warehouse updated successfully')),
          );
          Navigator.pop(context);
        } else {
          // Tampilkan pesan error jika update gagal
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to update warehouse')),
          );
        }
      }).catchError((e) {
        // Tampilkan pesan error jika ada masalah dengan API
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Warehouse'),
      ),
      body: FutureBuilder<Warehouse>(
        future: _warehouseFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Warehouse warehouse = snapshot.data!;
            _name = warehouse.name;
            _location = warehouse.location;
            return Padding(
              padding: EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: _name,
                      decoration: InputDecoration(labelText: 'Name'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a name';
                        }
                        return null;
                      },
                      onSaved: (value) => _name = value!,
                    ),
                    TextFormField(
                      initialValue: _location,
                      decoration: InputDecoration(labelText: 'Location'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a location';
                        }
                        return null;
                      },
                      onSaved: (value) => _location = value!,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _submitForm,
                      child: Text('Save'),
                    ),
                  ],
                ),
              ),
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
