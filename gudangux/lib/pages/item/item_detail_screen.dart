import 'package:flutter/material.dart';
import 'package:gudangux/models/item.dart';
import 'package:gudangux/pages/item/item_edit_screen.dart';
import 'package:gudangux/services/item_service.dart';

class ItemDetailScreen extends StatefulWidget {
  final int itemId;

  ItemDetailScreen({required this.itemId});

  @override
  _ItemDetailScreenState createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  late Future<Item> _itemFuture;

  @override
  void initState() {
    super.initState();
    _itemFuture = ItemService.getItemById(widget.itemId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Item Detail'),
      ),
      body: FutureBuilder<Item>(
        future: _itemFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Item item = snapshot.data!;
            return Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Name: ${item.name}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text('Description: ${item.description ?? 'N/A'}'),
                  SizedBox(height: 10),
                  Text('Quantity: ${item.quantity}'),
                  SizedBox(height: 10),
                  Text('Warehouse ID: ${item.warehouseId}'),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ItemEditScreen(itemId: widget.itemId),
            ),
          );
        },
        child: Icon(Icons.edit),
      ),
    );
  }
}