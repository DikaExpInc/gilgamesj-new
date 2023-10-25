class TaskModel {
  final int? statusCode;
  final String? sId;
  final String? title;
  final String? description;
  final String? stageId;
  final String? type;
  final String? detailId;
  final String? createdAt;
  final String? updatedAt;

  TaskModel({
    this.statusCode,
    this.sId,
    this.title,
    this.description,
    this.stageId,
    this.type,
    this.detailId,
    this.createdAt,
    this.updatedAt,
  });

  factory TaskModel.fromJson(Map<String, dynamic> jsonData) {
    return TaskModel(
      statusCode: jsonData['status_code'],
      sId: jsonData['_id'] != null ? jsonData['_id'] : "",
      title: jsonData['title'] != null ? jsonData['title'] : "",
      description:
          jsonData['description'] != null ? jsonData['description'] : "",
      stageId: jsonData['stage_id'] != null ? jsonData['stage_id'] : "",
      type: jsonData['type'] != null ? jsonData['type'] : "",
      detailId: jsonData['detail_id'] != null ? jsonData['detail_id'] : "",
      createdAt: jsonData['createdAt'] != null ? jsonData['createdAt'] : "",
      updatedAt: jsonData['updatedAt'] != null ? jsonData['updatedAt'] : "",
    );
  }
}

class TaskListModel {
  final int? statusCode; // 200 - 204 - 400 - 404
  final List<TaskModel>? items;

  TaskListModel({this.statusCode, this.items});

  factory TaskListModel.fromJson(Map<String, dynamic> jsonData) {
    return TaskListModel(
        statusCode: jsonData['status'],
        items: jsonData['items']
            .map<TaskModel>((data) => TaskModel.fromJson(data))
            .toList());
  }
}
