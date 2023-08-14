class GalleryPhotoModel {
  final int? statusCode;
  final String? sId;
  final String? title;
  final String? date;
  final String? image;
  final String? createdAt;
  final String? updatedAt;

  GalleryPhotoModel({
    this.statusCode,
    this.sId,
    this.title,
    this.date,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  factory GalleryPhotoModel.fromJson(Map<String, dynamic> jsonData) {
    return GalleryPhotoModel(
      statusCode: jsonData['status_code'],
      sId: jsonData['_id'] != null ? jsonData['_id'] : "",
      title: jsonData['title'] != null ? jsonData['title'] : "",
      date: jsonData['date'] != null ? jsonData['date'] : "",
      image: jsonData['image'] != null ? jsonData['image'] : "",
      createdAt: jsonData['createdAt'] != null ? jsonData['createdAt'] : "",
      updatedAt: jsonData['updatedAt'] != null ? jsonData['updatedAt'] : "",
    );
  }
}

class GalleryPhotoListModel {
  final int? statusCode; // 200 - 204 - 400 - 404
  final List<GalleryPhotoModel>? items;

  GalleryPhotoListModel({this.statusCode, this.items});

  factory GalleryPhotoListModel.fromJson(Map<String, dynamic> jsonData) {
    return GalleryPhotoListModel(
        statusCode: jsonData['status'],
        items: jsonData['items']
            .map<GalleryPhotoModel>((data) => GalleryPhotoModel.fromJson(data))
            .toList());
  }
}
