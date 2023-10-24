class SettingModel {
  final int? statusCode;
  final String? sId;
  final String? page;
  final String? player;
  final int? columns;
  final int? rows;
  final int? ishtarColumns;
  final int? ishtarRows;
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
    this.columns,
    this.rows,
    this.ishtarColumns,
    this.ishtarRows,
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
      columns: jsonData['columns'] != null ? jsonData['columns'] : 0,
      rows: jsonData['rows'] != null ? jsonData['rows'] : 0,
      ishtarColumns:
          jsonData['ishtarColumns'] != null ? jsonData['ishtarColumns'] : 0,
      ishtarRows: jsonData['ishtarRows'] != null ? jsonData['ishtarRows'] : 0,
      control: jsonData['control'] != null ? jsonData['control'] : "",
      stage_id: jsonData['stage_id'] != null ? jsonData['stage_id'] : "",
      notification:
          jsonData['notification'] != null ? jsonData['notification'] : "",
      createdAt: jsonData['createdAt'] != null ? jsonData['createdAt'] : "",
      updatedAt: jsonData['updatedAt'] != null ? jsonData['updatedAt'] : "",
    );
  }
}
