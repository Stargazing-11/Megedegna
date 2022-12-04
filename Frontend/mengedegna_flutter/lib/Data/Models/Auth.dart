class UserResponse {
  final String id;
  final String token;
  final String role;

  UserResponse({required this.id, required this.role, required this.token});

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
        id: json['_id'].toString(),
        role: json['role'].toString(),
        token: json['token'].toString());
  }
}
