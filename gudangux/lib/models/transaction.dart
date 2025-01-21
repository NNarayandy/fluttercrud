class Transaction {
  final int id;
  final int itemId;
  final int quantity;
  final String type;
  final DateTime date;

  Transaction({
    required this.id,
    required this.itemId,
    required this.quantity,
    required this.type,
    required this.date,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: int.tryParse(json['id'].toString()) ?? 0,
      itemId: int.tryParse(json['item_id'].toString()) ?? 0,
      quantity: int.tryParse(json['quantity'].toString()) ?? 0,
      type: json['type'] ?? 'undefined',
      date: DateTime.parse(json['date']),
    );
  }
}
