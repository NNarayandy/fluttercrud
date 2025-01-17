class Transaction {
  final int id;
  final int itemId;
  final int quantity;
  final String type;
  final String date;

  Transaction({
    required this.id,
    required this.itemId,
    required this.quantity,
    required this.type,
    required this.date,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: int.parse(json['id'] ?? '0'),
      itemId: int.parse(json['item_id'] ?? '0'),
      quantity: int.parse(json['quantity'] ?? '0'),
      type: json['type'] ?? '',
      date: json['date'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': itemId,
      'quantity': quantity,
      'type': type,
      'date': date,
    };
  }
}