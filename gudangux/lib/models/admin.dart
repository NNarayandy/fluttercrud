class Admin {
  final int id;
  final String username;
  final String email;
  final String phone;

  Admin({
    required this.id,
    required this.username,
    required this.email,
    required this.phone,
  });

  factory Admin.fromJson(Map<String, dynamic> json) {
    return Admin(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'phone': phone,
    };
  }
}