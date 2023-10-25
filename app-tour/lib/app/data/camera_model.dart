class CameraModel {
  final int? statusCode;
  final String? sId;
  final String? code;
  final String? name;
  final String? createdAt;
  final String? updatedAt;

  CameraModel({
    this.statusCode,
    this.sId,
    this.code,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  factory CameraModel.fromJson(Map<String, dynamic> jsonData) {
    return CameraModel(
      statusCode: jsonData['status_code'],
      sId: jsonData['_id'] != null ? jsonData['_id'] : "",
      code: jsonData['code'] != null ? jsonData['code'] : "",
      name: jsonData['name'] != null ? jsonData['name'] : "",
      createdAt: jsonData['createdAt'] != null ? jsonData['createdAt'] : "",
      updatedAt: jsonData['updatedAt'] != null ? jsonData['updatedAt'] : "",
    );
  }
}

class CameraListModel {
  final int? statusCode; // 200 - 204 - 400 - 404
  final List<CameraModel>? items;

  CameraListModel({this.statusCode, this.items});

  factory CameraListModel.fromJson(Map<String, dynamic> jsonData) {
    return CameraListModel(
        statusCode: jsonData['status'],
        items: jsonData['items']
            .map<CameraModel>((data) => CameraModel.fromJson(data))
            .toList());
  }
}
