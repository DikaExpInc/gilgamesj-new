class SocialMediaModel {
  final int? statusCode;
  final String? sId;
  final String? name;
  final String? description;
  final String? date;
  final int? like;
  final String? location;
  final String? profile;
  final String? postImage;
  final String? createdAt;
  final String? updatedAt;

  SocialMediaModel({
    this.statusCode,
    this.sId,
    this.name,
    this.description,
    this.date,
    this.like,
    this.location,
    this.profile,
    this.postImage,
    this.createdAt,
    this.updatedAt,
  });

  factory SocialMediaModel.fromJson(Map<String, dynamic> jsonData) {
    return SocialMediaModel(
      statusCode: jsonData['status_code'],
      sId: jsonData['_id'] != null ? jsonData['_id'] : "",
      name: jsonData['name'] != null ? jsonData['name'] : "",
      description:
          jsonData['description'] != null ? jsonData['description'] : "",
      date: jsonData['date'] != null ? jsonData['date'] : "",
      like: jsonData['like'] != null ? jsonData['like'] : 0,
      location: jsonData['location'] != null ? jsonData['location'] : "",
      profile: jsonData['profile'] != null ? jsonData['profile'] : "",
      postImage: jsonData['post_image'] != null ? jsonData['post_image'] : "",
      createdAt: jsonData['createdAt'] != null ? jsonData['createdAt'] : "",
      updatedAt: jsonData['updatedAt'] != null ? jsonData['updatedAt'] : "",
    );
  }
}

class SocialMediaListModel {
  final int? statusCode; // 200 - 204 - 400 - 404
  final List<SocialMediaModel>? items;

  SocialMediaListModel({this.statusCode, this.items});

  factory SocialMediaListModel.fromJson(Map<String, dynamic> jsonData) {
    return SocialMediaListModel(
      statusCode: jsonData['status'],
      items: jsonData['items']
          .map<SocialMediaModel>((data) => SocialMediaModel.fromJson(data))
          .toList(),
    );
  }
}
