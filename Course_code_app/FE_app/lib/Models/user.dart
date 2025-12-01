class User {
  int id;
  String email;
  int roleId;
  String fullName;
  String? avatarUrl;
  String? bio;

  User({
    required this.id,
    required this.email,
    required this.roleId,
    required this.fullName,
    this.avatarUrl,
    this.bio,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      email: json["email"],
      roleId: json["roleId"],
      fullName: json["fullName"],
      avatarUrl: json["avatarUrl"],
      bio: json["bio"],
    );
  }
}
