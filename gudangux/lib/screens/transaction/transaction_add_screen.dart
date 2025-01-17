import 'package:flutter/material.dart';
import 'package:gudangux/services/transaction_service.dart';
import 'package:intl/intl.dart';

class TransactionAddScreen extends StatefulWidget {
  @override
  _TransactionAddScreenState createState() => _TransactionAddScreenState();
}

class _TransactionAddScreenState extends State<TransactionAddScreen> {
  final _formKey = GlobalKey<FormState>();
  late int _itemId;
  late int _quantity;
  late String _type;
  late DateTime _date;

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      String formattedDate = DateFormat('yyyy-MM-dd').format(_date);
      TransactionService.createTransaction(_itemId, _quantity, _type, formattedDate)
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
        title: Text('Add Transaction'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Item ID'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an item ID';
                  }
                  return null;
                },
                onSaved: (value) => _itemId = int.parse(value!),
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
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Type'),
                items: ['in', 'out'].map((type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a type';
                  }
                  return null;
                },
                onChanged: (value) => _type = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Date'),
                onTap: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) {
                    setState(() {
                      _date = picked;
                    });
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a date';
                  }
                  return null;
                },
                controller: TextEditingController(
                  text: _date != null ? DateFormat('yyyy-MM-dd').format(_date) : '',
                ),
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