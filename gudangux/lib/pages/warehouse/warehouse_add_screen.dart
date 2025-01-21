import 'package:flutter/material.dart';
import 'package:gudangux/config/api.dart';
import 'package:gudangux/pages/warehouse/warehouse_list_screen.dart';

class WarehouseAddScreen extends StatefulWidget {
  @override
  _WarehouseAddScreenState createState() => _WarehouseAddScreenState();
}

class _WarehouseAddScreenState extends State<WarehouseAddScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _location;

  void _createWarehouse() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        final result = await Api.createWarehouse(_name, _location);
        print('Success: ${result['message']}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Warehouse created successfully!'),
          ),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => WarehouseListScreen()),
        );
      } catch (e) {
        print('Error: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to create warehouse: $e'),
          ),
        );
      }
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
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => WarehouseListScreen()),
            );
          },
        ),
      ),
      body: Center(
        child: Container(
          width: 350,
          height: 350,
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
                  'Add Warehouse',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 2, 130, 227),
                  ),
                ),
              ),
              Divider(color: Colors.grey, thickness: 1),
              SizedBox(height: 16.0),
              Form(
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
                      onPressed: _createWarehouse,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 2, 130, 227),
                        minimumSize: Size(double.infinity, 44),
                      ),
                      child: Text(
                        'Save',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}