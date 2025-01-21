import 'package:flutter/material.dart';
import 'package:gudangux/config/api.dart';
import 'package:gudangux/models/item.dart';
import 'package:gudangux/pages/item/ItemDetail.dart';
import 'package:gudangux/pages/item/item_add_screen.dart';
import 'package:gudangux/pages/admin/DashboardAdmin.dart';

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

  Future<List<Item>> _fetchItems() async {
    try {
      List<Item> items = await Api.getDataItemFunction();
      return items;
    } catch (e) {
      throw Exception('Failed to load items: $e');
    }
  }

  void _deleteItem(int id) async {
    try {
      final response = await Api.deleteItem(id);
      print('Response: ${response.toString()}');

      if (response['success']) {
        setState(() {
          _itemsFuture = _fetchItems();
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Item deleted successfully')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response['message'])),
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
      backgroundColor: const Color.fromARGB(225, 130, 172, 225),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(225, 130, 172, 225),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AdminHomeScreen(adminId: 1)), // Replace 1 with the actual adminId
            );
          },
        ),
      ),
      body: Center(
        child: Container(
          width: 400,
          height: 400,
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
          child: Column(
            children: [
              Center(
                child: Text(
                  'Items',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 2, 130, 227),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Expanded(
                child: FutureBuilder<List<Item>>(
                  future: _itemsFuture,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Item> items = snapshot.data!;
                      return ListView.separated(
                        itemCount: items.length,
                        separatorBuilder: (context, index) => Divider(
                          color: Colors.grey,
                          thickness: 1,
                        ),
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
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ItemAddScreen()),
          );
        },
        backgroundColor: const Color.fromARGB(255, 2, 130, 227),
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}