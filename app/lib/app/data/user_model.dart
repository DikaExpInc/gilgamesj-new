import 'package:app/app/data/player_model.dart';

class UserModel {
  final int? statusCode;
  final String? role;
  final String? status;
  final List<PlayerModel>? players;
  final String? sId;
  final String? username;
  final String? email;
  final String? createdAt;
  final String? updatedAt;
  final String? accessToken;
  final String? tokenType;

  UserModel({
    this.statusCode,
    this.role,
    this.status,
    this.players,
    this.sId,
    this.username,
    this.email,
    this.createdAt,
    this.updatedAt,
    this.accessToken,
    this.tokenType,
  });

  factory UserModel.fromJson(Map<String, dynamic> jsonData) {
    final List<PlayerModel> playerList = [];
    if (jsonData['players'] != null) {
      jsonData['players'].forEach((v) {
        playerList.add(PlayerModel.fromJson(v));
      });
    }
    return UserModel(
      role: jsonData['role'],
      statusCode: jsonData['status_code'],
      status: jsonData['status'],
      sId: jsonData['_id'],
      username: jsonData['username'],
      players: playerList,
      email: jsonData['email'],
      createdAt: jsonData['createdAt'],
      updatedAt: jsonData['updatedAt'],
      accessToken: jsonData['access_token'],
      tokenType: jsonData['token_type'],
    );
  }
}
