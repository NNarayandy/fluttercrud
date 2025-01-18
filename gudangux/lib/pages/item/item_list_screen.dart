import 'package:flutter/material.dart';
import 'package:gudangux/config/api.dart';
import 'package:gudangux/models/item.dart';
import 'package:gudangux/pages/item/ItemDetail.dart';
import 'package:gudangux/pages/item/item_add_screen.dart';

class ItemListScreen extends StatefulWidget {
  @override
  _ItemListScreenState createState() => _ItemListScreenState();
}

class _ItemListScreenState extends State<ItemListScreen> {
  late Future<List<Item>> _itemsFuture;

  @override
  void initState() {
    super.initState();
    _itemsFuture = _fetchItems();
  }

  // Fungsi untuk mengambil data item
  Future<List<Item>> _fetchItems() async {
    try {
      // Memanggil fungsi API untuk mengambil data item
      List<Item> items = await Api.getDataItemFunction();
      return items;
    } catch (e) {
      throw Exception('Failed to load items: $e');
    }
  }

  // Fungsi untuk menghapus item
  void _deleteItem(int id) async {
  try {
    final response = await Api.deleteItem(id);  // Memanggil fungsi API untuk menghapus item
    print('Response: ${response.toString()}');  // Untuk melihat hasil respons API

    if (response['success']) {
      setState(() {
        _itemsFuture = _fetchItems(); // Memperbarui list item setelah dihapus
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Item deleted successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response['message'])), // Menampilkan pesan jika gagal
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('An error occurred while deleting item: $e')),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Items'),
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
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _deleteItem(item.id),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ItemDetail(itemId: item.id),
                      ),
                    );
                  },
                );
              },
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
            MaterialPageRoute(builder: (context) => ItemAddScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
