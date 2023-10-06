class PlayerModel {
  final int? statusCode;
  final String? sId;
  final String? username;
  final int? playerNum;
  final int? time;
  final String? statusPlay;
  final String? statusDone;
  final String? userId;
  final String? seatId;
  final String? seat;
  final String? stageId;

  PlayerModel({
    this.statusCode,
    this.sId,
    this.username,
    this.playerNum,
    this.time,
    this.statusPlay,
    this.statusDone,
    this.userId,
    this.seatId,
    this.seat,
    this.stageId,
  });

  factory PlayerModel.fromJson(Map<String, dynamic> jsonData) {
    return PlayerModel(
      statusCode: jsonData['status_code'],
      sId: jsonData['_id'] != null ? jsonData['_id'] : "",
      username: jsonData['username'] != null ? jsonData['status_code'] : "",
      playerNum: jsonData['player_num'] != null ? jsonData['player_num'] : 0,
      time: jsonData['time'] != null ? jsonData['time'] : 0,
      statusPlay:
          jsonData['status_play'] != null ? jsonData['status_play'] : "",
      statusDone:
          jsonData['status_done'] != null ? jsonData['status_done'] : "",
      userId: jsonData['user_id'] != null ? jsonData['user_id'] : "",
      seatId: jsonData['seat_id'] != null ? jsonData['seat_id'] : "",
      seat: jsonData['seat'] != null ? jsonData['seat'] : "",
      stageId: jsonData['stage_id'] != null ? jsonData['stage_id'] : "",
    );
  }
}

class PlayerListModel {
  final int? statusCode; // 200 - 204 - 400 - 404
  final List<PlayerModel>? items;

  PlayerListModel({this.statusCode, this.items});

  factory PlayerListModel.fromJson(Map<String, dynamic> jsonData) {
    return PlayerListModel(
        statusCode: jsonData['status'],
        items: jsonData['items']
            .map<PlayerModel>((data) => PlayerModel.fromJson(data))
            .toList());
  }
}
