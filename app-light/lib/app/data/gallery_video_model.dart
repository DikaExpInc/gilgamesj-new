class GalleryVideoModel {
  final int? statusCode;
  final String? sId;
  final String? title;
  final String? date;
  final String? thumbnail;
  final String? video;
  final String? createdAt;
  final String? updatedAt;

  GalleryVideoModel({
    this.statusCode,
    this.sId,
    this.title,
    this.date,
    this.thumbnail,
    this.video,
    this.createdAt,
    this.updatedAt,
  });

  factory GalleryVideoModel.fromJson(Map<String, dynamic> jsonData) {
    return GalleryVideoModel(
      statusCode: jsonData['status_code'],
      sId: jsonData['_id'] != null ? jsonData['_id'] : "",
      title: jsonData['title'] != null ? jsonData['title'] : "",
      date: jsonData['date'] != null ? jsonData['date'] : "",
      thumbnail: jsonData['thumbnail'] != null ? jsonData['thumbnail'] : "",
      video: jsonData['video'] != null ? jsonData['video'] : "",
      createdAt: jsonData['createdAt'] != null ? jsonData['createdAt'] : "",
      updatedAt: jsonData['updatedAt'] != null ? jsonData['updatedAt'] : "",
    );
  }
}

class GalleryVideoListModel {
  final int? statusCode; // 200 - 204 - 400 - 404
  final List<GalleryVideoModel>? items;

  GalleryVideoListModel({this.statusCode, this.items});

  factory GalleryVideoListModel.fromJson(Map<String, dynamic> jsonData) {
    return GalleryVideoListModel(
        statusCode: jsonData['status'],
        items: jsonData['items']
            .map<GalleryVideoModel>((data) => GalleryVideoModel.fromJson(data))
            .toList());
  }
}
