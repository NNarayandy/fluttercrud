import 'package:flutter/material.dart';
import 'package:gudangux/models/warehouse.dart';
import 'package:gudangux/services/warehouse_service.dart';

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
    _warehouseFuture = WarehouseService.getWarehouseById(widget.warehouseId);
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      WarehouseService.updateWarehouse(widget.warehouseId, _name, _location)
          .then((success) {
        if (success) {
          Navigator.pop(context);
        } else {
          // Show error message
        }
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