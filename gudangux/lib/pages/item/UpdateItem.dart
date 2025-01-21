import 'package:flutter/material.dart';
import 'package:gudangux/models/item.dart';
import 'package:gudangux/config/api.dart';
import 'package:gudangux/pages/item/item_list_screen.dart';

class UpdateItem extends StatefulWidget {
  final int itemId;

  const UpdateItem({Key? key, required this.itemId}) : super(key: key);

  @override
  _UpdateItemState createState() => _UpdateItemState();
}

class _UpdateItemState extends State<UpdateItem> {
  final _formKey = GlobalKey<FormState>();
  late Future<Item> _itemFuture;
  late int _id;
  late String _name;
  late String _description;
  late int _quantity;
  late int _warehouseId;

  @override
  void initState() {
    super.initState();
    _itemFuture = Api.detailItem(widget.itemId).then((data) {
      Item item = Item.fromJson(data);
      _id = item.id;
      _name = item.name;
      _description = item.description ?? '';
      _quantity = item.quantity;
      _warehouseId = item.warehouseId ?? 0;
      return item;
    });
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      print('Form data - ID: $_id, Name: $_name, Description: $_description, Quantity: $_quantity, Warehouse ID: $_warehouseId');

      try {
        final response = await Api.updateItemFunction(
          _id,
          _name,
          _description,
          _quantity,
          _warehouseId,
        );
        if (response['success']) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ItemListScreen()),
          );
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
          SnackBar(content: Text('An error occurred: $e')),
        );
      }
    }
  }

  Widget _buildReadOnlyField(String label, String value) {
    return TextFormField(
      initialValue: value,
      decoration: InputDecoration(labelText: label),
      readOnly: true,
    );
  }

  Widget _buildTextField(String label, String initialValue, Function(String) onSaved, {bool isNumeric = false}) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(labelText: label),
      keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
      onSaved: (value) => onSaved(value!),
    );
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
              MaterialPageRoute(builder: (context) => ItemListScreen()),
            );
          },
        ),
      ),
      body: Center(
        child: Container(
          width: 400,
          height: 450,
          margin: EdgeInsets.all(16.0),
          padding: EdgeInsets.all(20.0),
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
          child: FutureBuilder<Item>(
            future: _itemFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                return Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _buildReadOnlyField('ID', _id.toString()),
                      _buildTextField('Name', _name, (value) => _name = value),
                      _buildTextField('Description', _description, (value) => _description = value),
                      _buildTextField('Quantity', _quantity.toString(), (value) => _quantity = int.parse(value), isNumeric: true),
                      _buildTextField('Warehouse ID', _warehouseId.toString(), (value) => _warehouseId = int.parse(value), isNumeric: true),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _submitForm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 2, 130, 227),
                          minimumSize: Size(double.infinity, 48),
                        ),
                        child: Text(
                          'Save',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                );
              }
              return Center(child: Text('No data found'));
            },
          ),
        ),
      ),
    );
  }
}