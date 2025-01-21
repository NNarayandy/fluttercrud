import 'package:flutter/material.dart';
import 'package:gudangux/config/api.dart';
import 'package:gudangux/models/item.dart';
import 'package:gudangux/pages/auth/welcomePage.dart';

class ItemListScreenGuest extends StatefulWidget {
  @override
  _ItemListScreenGuestState createState() => _ItemListScreenGuestState();
}

class _ItemListScreenGuestState extends State<ItemListScreenGuest> {
  late Future<List<Item>> _itemsFuture;

  @override
  void initState() {
    super.initState();
    _itemsFuture = Api.getDataItemFunction(); // Memanggil API untuk mengambil data item
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(225, 130, 172, 225),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Welcomepage()),
            );
          },
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(225, 130, 172, 225),
        ),
        child: Center(
          child: Container(
            width: 500,
            height: 400,
            margin: EdgeInsets.all(16.0),
            padding: EdgeInsets.all(16.0),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Items Guest',
                    style: TextStyle(
                      fontSize: 24,
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
      ),
    );
  }
}