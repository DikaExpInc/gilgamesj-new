class SocialMediaCommentModel {
  final int? statusCode;
  final String? sId;
  final String? name;
  final String? comment;
  final String? profile;
  final String? createdAt;
  final String? updatedAt;

  SocialMediaCommentModel({
    this.statusCode,
    this.sId,
    this.name,
    this.comment,
    this.profile,
    this.createdAt,
    this.updatedAt,
  });

  factory SocialMediaCommentModel.fromJson(Map<String, dynamic> jsonData) {
    return SocialMediaCommentModel(
      statusCode: jsonData['status_code'],
      sId: jsonData['_id'] != null ? jsonData['_id'] : "",
      name: jsonData['name'] != null ? jsonData['name'] : "",
      comment: jsonData['comment'] != null ? jsonData['comment'] : "",
      profile: jsonData['profile'] != null ? jsonData['profile'] : "",
      createdAt: jsonData['createdAt'] != null ? jsonData['createdAt'] : "",
      updatedAt: jsonData['updatedAt'] != null ? jsonData['updatedAt'] : "",
    );
  }
}

class SocialMediaCommentListModel {
  final int? statusCode; // 200 - 204 - 400 - 404
  final List<SocialMediaCommentModel>? items;

  SocialMediaCommentListModel({this.statusCode, this.items});

  factory SocialMediaCommentListModel.fromJson(Map<String, dynamic> jsonData) {
    return SocialMediaCommentListModel(
      statusCode: jsonData['status'],
      items: jsonData['items']
          .map<SocialMediaCommentModel>(
              (data) => SocialMediaCommentModel.fromJson(data))
          .toList(),
    );
  }
}
