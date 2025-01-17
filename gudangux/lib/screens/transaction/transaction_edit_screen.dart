import 'package:flutter/material.dart';
import 'package:gudangux/models/transaction.dart';
import 'package:gudangux/services/transaction_service.dart';
import 'package:intl/intl.dart';

class TransactionEditScreen extends StatefulWidget {
  final int transactionId;

  TransactionEditScreen({required this.transactionId});

  @override
  _TransactionEditScreenState createState() => _TransactionEditScreenState();
}

class _TransactionEditScreenState extends State<TransactionEditScreen> {
  final _formKey = GlobalKey<FormState>();
  late Future<Transaction> _transactionFuture;
  late int _itemId;
  late int _quantity;
  late String _type;
  late DateTime _date;

  @override
  void initState() {
    super.initState();
    _transactionFuture = TransactionService.getTransactionById(widget.transactionId);
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      String formattedDate = DateFormat('yyyy-MM-dd').format(_date);
      TransactionService.updateTransaction(widget.transactionId, _itemId, _quantity, _type, formattedDate)
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
        title: Text('Edit Transaction'),
      ),
      body: FutureBuilder<Transaction>(
        future: _transactionFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Transaction transaction = snapshot.data!;
            _itemId = transaction.itemId;
            _quantity = transaction.quantity;
            _type = transaction.type;
            _date = DateTime.parse(transaction.date);
            return Padding(
              padding: EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: _itemId.toString(),
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
                    DropdownButtonFormField<String>(
                      value: _type,
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
                      initialValue: DateFormat('yyyy-MM-dd').format(_date),
                      decoration: InputDecoration(labelText: 'Date'),
                      onTap: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: _date,
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
                        text: DateFormat('yyyy-MM-dd').format(_date),
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