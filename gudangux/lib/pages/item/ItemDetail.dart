import 'package:flutter/material.dart';
import 'package:gudangux/config/api.dart';
import 'package:gudangux/pages/item/UpdateItem.dart';
import 'package:gudangux/pages/item/item_list_screen.dart';

class ItemDetail extends StatefulWidget {
  final int itemId;

  ItemDetail({required this.itemId});

  @override
  _ItemDetailState createState() => _ItemDetailState();
}

class _ItemDetailState extends State<ItemDetail> {
  late Future<Map<String, dynamic>> _itemFuture;

  @override
  void initState() {
    super.initState();
    _itemFuture = Api.detailItem(widget.itemId);
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
            Navigator.push(
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
          child: FutureBuilder<Map<String, dynamic>>(
            future: _itemFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'Error: ${snapshot.error}',
                    style: TextStyle(color: Colors.red, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                );
              } else if (snapshot.hasData) {
                final item = snapshot.data!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name: ${item['name']}',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text('Description: ${item['description']}'),
                    SizedBox(height: 10),
                    Text('Quantity: ${item['quantity']}'),
                    SizedBox(height: 10),
                    Text('Warehouse ID: ${item['warehouse_id']}'),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UpdateItem(itemId: widget.itemId),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 2, 130, 227),
                        minimumSize: Size(double.infinity, 48),
                      ),
                      child: Text(
                        'Update Item',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ],
                );
              } else {
                return Center(child: Text('No data found.'));
              }
            },
          ),
        ),
      ),
    );
  }
}