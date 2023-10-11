class SettingModel {
  final int? statusCode;
  final String? sId;
  final String? page;
  final String? player;
  final String? control;
  final String? stage_id;
  final String? notification;
  final String? createdAt;
  final String? updatedAt;

  SettingModel({
    this.statusCode,
    this.sId,
    this.page,
    this.player,
    this.control,
    this.stage_id,
    this.notification,
    this.createdAt,
    this.updatedAt,
  });

  factory SettingModel.fromJson(Map<String, dynamic> jsonData) {
    return SettingModel(
      statusCode: jsonData['status_code'],
      sId: jsonData['_id'] != null ? jsonData['_id'] : "",
      page: jsonData['page'] != null ? jsonData['page'] : "",
      player: jsonData['player'] != null ? jsonData['player'] : "",
      control: jsonData['control'] != null ? jsonData['control'] : "",
      stage_id: jsonData['stage_id'] != null ? jsonData['stage_id'] : "",
      notification:
          jsonData['notification'] != null ? jsonData['notification'] : "",
      createdAt: jsonData['createdAt'] != null ? jsonData['createdAt'] : "",
      updatedAt: jsonData['updatedAt'] != null ? jsonData['updatedAt'] : "",
    );
  }
}
