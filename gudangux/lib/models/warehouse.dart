// warehouse.dart
class Warehouse {
  final int id;
  final String name;
  final String location;

  Warehouse({
    required this.id,
    required this.name,
    required this.location,
  });

  factory Warehouse.fromJson(Map<String, dynamic> json) {
    return Warehouse(
      id: int.parse(json['id']),
      name: json['name'],
      location: json['location'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'location': location,
    };
  }
}