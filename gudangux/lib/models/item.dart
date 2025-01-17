class Item {
  final int id;
  final String name;
  final String? description;
  final int quantity;
  final int warehouseId;

  Item({
    required this.id,
    required this.name,
    this.description,
    required this.quantity,
    required this.warehouseId,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: int.parse(json['id']),
      name: json['name'] ?? '',
      description: json['description'],
      quantity: int.parse(json['quantity'].toString()),
      warehouseId: int.parse(json['warehouse_id'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'quantity': quantity,
      'warehouse_id': warehouseId,
    };
  }
}