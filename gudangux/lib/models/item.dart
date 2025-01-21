class Item {
  final int id;
  final String name;
  final String? description; // Nullable jika bisa kosong
  final int quantity;
  final int? warehouseId; // Nullable jika tidak selalu ada

  Item({
    required this.id,
    required this.name,
    this.description,
    required this.quantity,
    this.warehouseId,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: int.tryParse(json['id'].toString()) ?? 0, // Fallback ke 0 jika parsing gagal
      name: json['name'] ?? 'Unknown', // Default value jika null
      description: json['description'] ?? '', // Default kosong jika null
      quantity: int.tryParse(json['quantity'].toString()) ?? 0, // Fallback ke 0
      warehouseId: json['warehouse_id'] != null
          ? int.tryParse(json['warehouse_id'].toString())
          : null, // Nullable jika null
    );
  }
}
