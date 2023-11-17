import 'package:gilgamesj_tour/app/data/player_model.dart';

class UserModel {
  final int? statusCode;
  final String? role;
  final String? userType;
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
    this.userType,
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
      role: jsonData['role'] != null ? jsonData['role'] : "",
      userType: jsonData['user_type'] != null ? jsonData['user_type'] : "",
      statusCode:
          jsonData['status_code'] != null ? jsonData['status_code'] : "",
      status: jsonData['status'] != null ? jsonData['status'] : "",
      sId: jsonData['_id'] != null ? jsonData['_id'] : "",
      username: jsonData['username'] != null ? jsonData['username'] : "",
      players: playerList,
      email: jsonData['email'] != null ? jsonData['email'] : "",
      createdAt: jsonData['createdAt'] != null ? jsonData['createdAt'] : "",
      updatedAt: jsonData['updatedAt'] != null ? jsonData['updatedAt'] : "",
      accessToken:
          jsonData['access_token'] != null ? jsonData['access_token'] : "",
      tokenType: jsonData['token_type'] != null ? jsonData['token_type'] : "",
    );
  }
}
