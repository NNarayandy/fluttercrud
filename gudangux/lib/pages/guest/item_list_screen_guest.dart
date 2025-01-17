import 'package:flutter/material.dart';
import 'package:gudangux/config/api.dart';
import 'package:gudangux/models/item.dart';

class ItemListScreenGuest extends StatefulWidget {
  @override
  _ItemListScreenGuestState createState() => _ItemListScreenGuestState();
}

class _ItemListScreenGuestState extends State<ItemListScreenGuest> {
  late Future<List<Item>> _itemsFuture;

  @override
  void initState() {
    super.initState();
    _itemsFuture = _fetchItems();
  }

  Future<List<Item>> _fetchItems() async {
    try {
      final response = await Api.readItem(); // Memanggil fungsi dari api.dart
      List<Item> items = (response['items'] as List)
          .map((item) => Item.fromJson(item))
          .toList();
      return items;
    } catch (e) {
      throw Exception('Failed to load items: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Items Guest'),
      ),
      body: FutureBuilder<List<Item>>(
        future: _itemsFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Item> items = snapshot.data!;
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                Item item = items[index];
                return ListTile(
                  title: Text(item.name),
                  subtitle: Text('Quantity: ${item.quantity}'),
                );
              },
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
