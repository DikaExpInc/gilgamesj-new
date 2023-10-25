class BrowserModel {
  final int? statusCode;
  final String? sId;
  final String? title;
  final String? description;
  final String? image;
  final String? createdAt;
  final String? updatedAt;

  BrowserModel({
    this.statusCode,
    this.sId,
    this.title,
    this.description,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  factory BrowserModel.fromJson(Map<String, dynamic> jsonData) {
    return BrowserModel(
      statusCode: jsonData['status_code'],
      sId: jsonData['_id'] != null ? jsonData['_id'] : "",
      title: jsonData['title'] != null ? jsonData['title'] : "",
      description:
          jsonData['description'] != null ? jsonData['description'] : "",
      image: jsonData['image'] != null ? jsonData['image'] : "",
      createdAt: jsonData['createdAt'] != null ? jsonData['createdAt'] : "",
      updatedAt: jsonData['updatedAt'] != null ? jsonData['updatedAt'] : "",
    );
  }
}

class BrowserListModel {
  final int? statusCode; // 200 - 204 - 400 - 404
  final List<BrowserModel>? items;

  BrowserListModel({this.statusCode, this.items});

  factory BrowserListModel.fromJson(Map<String, dynamic> jsonData) {
    return BrowserListModel(
        statusCode: jsonData['status'],
        items: jsonData['items']
            .map<BrowserModel>((data) => BrowserModel.fromJson(data))
            .toList());
  }
}
