import 'package:flutter/material.dart';
import 'package:gudangux/services/warehouse_service.dart';

class WarehouseAddScreen extends StatefulWidget {
  @override
  _WarehouseAddScreenState createState() => _WarehouseAddScreenState();
}

class _WarehouseAddScreenState extends State<WarehouseAddScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _location;

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      WarehouseService.createWarehouse(_name, _location)
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
        title: Text('Add Warehouse'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
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
      ),
    );
  }
}