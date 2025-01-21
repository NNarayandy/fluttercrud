class Warehouse {
  final String name;
  final String location;

  Warehouse({required this.name, required this.location});

  factory Warehouse.fromJson(Map<String, dynamic> json) {
    return Warehouse(
      name: json['name'],
      location: json['location'],
    );
  }
}