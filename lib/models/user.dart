class User {
  final int id;
  final String email;
  final String password;
  final String name;
  final String? avatar;
  final String? role;

  User({
    required this.id,
    required this.email,
    required this.password,
    required this.name,
    this.avatar,
    this.role = 'customer',
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      password: json['password'],
      name: json['name'],
      avatar: json['avatar'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'name': name,
      'avatar': avatar,
      'role': role,
    };
  }
}