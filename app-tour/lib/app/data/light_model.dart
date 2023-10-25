class LightModel {
  final int? statusCode;
  final String? sId;
  final String? light_array;
  final String? name;
  final String? createdAt;
  final String? updatedAt;

  LightModel({
    this.statusCode,
    this.sId,
    this.light_array,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  factory LightModel.fromJson(Map<String, dynamic> jsonData) {
    return LightModel(
      statusCode: jsonData['status_light_array'],
      sId: jsonData['_id'] != null ? jsonData['_id'] : "",
      light_array: jsonData['light_array'] != null ? jsonData['light_array'] : "",
      name: jsonData['name'] != null ? jsonData['name'] : "",
      createdAt: jsonData['createdAt'] != null ? jsonData['createdAt'] : "",
      updatedAt: jsonData['updatedAt'] != null ? jsonData['updatedAt'] : "",
    );
  }
}

class LightListModel {
  final int? statusCode; // 200 - 204 - 400 - 404
  final List<LightModel>? items;

  LightListModel({this.statusCode, this.items});

  factory LightListModel.fromJson(Map<String, dynamic> jsonData) {
    return LightListModel(
        statusCode: jsonData['status'],
        items: jsonData['items']
            .map<LightModel>((data) => LightModel.fromJson(data))
            .toList());
  }
}
