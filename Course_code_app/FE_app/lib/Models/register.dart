class RegisterRequest {
  final String fullName;
  final String email;
  final String password;
  final int roleId;

  RegisterRequest({
    required this.fullName,
    required this.email,
    required this.password,
    required this.roleId,
  });

  Map<String, dynamic> toJson() => {
        'Email': email,
        'PasswordHash': password,
        'RoleId': roleId,
        'FullName': fullName,
      };
}