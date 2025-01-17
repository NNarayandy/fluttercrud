class Item {
  final int id;
  final String name;
  final int quantity;

  Item({required this.id, required this.name, required this.quantity});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: int.parse(json['id']),
      name: json['name'],
      quantity: int.parse(json['quantity']),
    );
  }
}
