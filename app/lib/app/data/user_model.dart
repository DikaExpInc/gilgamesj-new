import 'dart:convert';

class UserModel {
  final int? status;
  final int? id;
  final String? name;
  final String? email;
  final String? accessToken;
  final String? tokenType;

  UserModel({
    this.status,
    this.id,
    this.name,
    this.email,
    this.accessToken,
    this.tokenType,
  });

  factory UserModel.fromJson(Map<String, dynamic> jsonData) {
    return UserModel(
      status: jsonData['status'],
      id: jsonData['id'],
      name: jsonData['name'],
      email: jsonData['email'],
      accessToken: jsonData['access_token'],
      tokenType: jsonData['token_type'],
    );
  }
}
