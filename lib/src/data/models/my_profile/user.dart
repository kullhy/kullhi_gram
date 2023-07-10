class User {
  String? name;
  String? email;
  String? phone;
  String? permission;

  User({
    this.name,
    this.email,
    this.phone,
    this.permission,
  });

  User copyWith({
    String? name,
    String? email,
    String? phone,
    String? permission,
  }) =>
      User(
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        permission: permission ?? this.permission,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        permission: json["permission"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "phone": phone,
        "permission": permission,
      };
}
