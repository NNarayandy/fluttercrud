import 'package:flutter/material.dart';
import 'package:gudangux/services/item_service.dart';

class ItemAddScreen extends StatefulWidget {
  @override
  _ItemAddScreenState createState() => _ItemAddScreenState();
}

class _ItemAddScreenState extends State<ItemAddScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _description;
  late int _quantity;
  late int _warehouseId;

// ...

// ...

void _submitForm() async {
  if (_formKey.currentState!.validate()) {
    _formKey.currentState!.save();
    try {
      final response = await ItemService.createItem(_name, _description, _quantity, _warehouseId);
      if (response['success']) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Item created successfully')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response['message'])),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred while creating item')),
      );
    }
  }
}

// ...

// ...

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Item'),
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
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
                onSaved: (value) => _description = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Quantity'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a quantity';
                  }
                  return null;
                },
                onSaved: (value) => _quantity = int.parse(value!),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Warehouse ID'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a warehouse ID';
                  }
                  return null;
                },
                onSaved: (value) => _warehouseId = int.parse(value!),
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