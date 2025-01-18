import 'package:flutter/material.dart';
import 'package:gudangux/config/api.dart';
import 'package:gudangux/models/item.dart';
import 'package:gudangux/pages/item/UpdateItem.dart';

class ItemDetail extends StatefulWidget {
  final int itemId;

  ItemDetail({required this.itemId});

  @override
  _ItemDetailState createState() => _ItemDetailState();
}

class _ItemDetailState extends State<ItemDetail> {
  late Future<Item> _itemFuture;

  @override
  void initState() {
    super.initState();
    _itemFuture = _fetchItemDetail(widget.itemId);
  }

  Future<Item> _fetchItemDetail(int id) async {
    try {
      final response = await Api.detailItem(id); // Panggil API detailItem
      if (response['success']) {
        return Item.fromJson(response['data']); // Parsing JSON ke model Item
      } else {
        throw Exception(response['message']);
      }
    } catch (e) {
      throw Exception('Failed to load item detail: $e');
    }
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
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
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
                  Text('Description: ${item.description}'),
                  SizedBox(height: 10),
                  Text('Quantity: ${item.quantity}'),
                  SizedBox(height: 10),
                  Text('Warehouse ID: ${item.warehouseId}'),
                ],
              ),
            );
          } else {
            return Center(child: Text('No data found.'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UpdateItem(itemId: widget.itemId),
            ),
          );
        },
        child: Icon(Icons.edit),
      ),
    );
  }
}
