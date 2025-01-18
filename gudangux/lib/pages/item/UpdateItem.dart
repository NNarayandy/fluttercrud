import 'package:flutter/material.dart';
import 'package:gudangux/models/item.dart';
import 'package:gudangux/config/api.dart';

class UpdateItem extends StatefulWidget {
  final int itemId;

  UpdateItem({required this.itemId});

  @override
  _UpdateItemState createState() => _UpdateItemState();
}

class _UpdateItemState extends State<UpdateItem> {
  final _formKey = GlobalKey<FormState>();
  late Future<Item> _itemFuture;
  late String _name;
  late String _description;
  late int _quantity;
  late int _warehouseId;

  @override
  void initState() {
    super.initState();
    _itemFuture = Api.detailItem(widget.itemId).then((data) {
      return Item.fromJson(data['data']); // Pastikan format response cocok
    });
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        final response = await Api.updateItemFunction(
          widget.itemId,
          _name,
          _description,
          _quantity,
          _warehouseId,
        );
        if (response['success']) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Item updated successfully')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(response['message'])),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An error occurred while updating item')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Item'),
      ),
      body: FutureBuilder<Item>(
        future: _itemFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Item item = snapshot.data!;
            _name = item.name;
            _description = item.description ?? '';
            _quantity = item.quantity;
            _warehouseId = item.warehouseId!;
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
                      initialValue: _description,
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
                      initialValue: _quantity.toString(),
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
                      initialValue: _warehouseId.toString(),
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
