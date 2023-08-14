class MapModel {
  final int? statusCode;
  final String? sId;
  final String? title;
  final String? description;
  final String? latitude;
  final String? longitude;
  final String? image;
  final String? createdAt;
  final String? updescriptiondAt;

  MapModel({
    this.statusCode,
    this.sId,
    this.title,
    this.description,
    this.latitude,
    this.longitude,
    this.image,
    this.createdAt,
    this.updescriptiondAt,
  });

  factory MapModel.fromJson(Map<String, dynamic> jsonData) {
    return MapModel(
      statusCode: jsonData['status_code'],
      sId: jsonData['_id'] != null ? jsonData['_id'] : "",
      title: jsonData['title'] != null ? jsonData['title'] : "",
      description:
          jsonData['description'] != null ? jsonData['description'] : "",
      latitude: jsonData['latitude'] != null ? jsonData['latitude'] : "",
      longitude: jsonData['longitude'] != null ? jsonData['longitude'] : "",
      image: jsonData['image'] != null ? jsonData['image'] : "",
      createdAt: jsonData['createdAt'] != null ? jsonData['createdAt'] : "",
      updescriptiondAt: jsonData['updescriptiondAt'] != null
          ? jsonData['updescriptiondAt']
          : "",
    );
  }
}

class MapListModel {
  final int? statusCode; // 200 - 204 - 400 - 404
  final List<MapModel>? items;

  MapListModel({this.statusCode, this.items});

  factory MapListModel.fromJson(Map<String, dynamic> jsonData) {
    return MapListModel(
        statusCode: jsonData['status'],
        items: jsonData['items']
            .map<MapModel>((data) => MapModel.fromJson(data))
            .toList());
  }
}
