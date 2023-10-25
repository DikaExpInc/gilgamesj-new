class PlayerChatModel {
  final int? statusCode;
  final String? sId;
  final String? title;
  final String? status;
  final String? sender;
  final int? order;
  final String? createdAt;
  final String? updatedAt;

  PlayerChatModel({
    this.statusCode,
    this.sId,
    this.title,
    this.status,
    this.sender,
    this.order,
    this.createdAt,
    this.updatedAt,
  });

  factory PlayerChatModel.fromJson(Map<String, dynamic> jsonData) {
    return PlayerChatModel(
      statusCode: jsonData['status_code'],
      sId: jsonData['_id'] != null ? jsonData['_id'] : "",
      title: jsonData['title'] != null ? jsonData['title'] : "",
      status: jsonData['status'] != null ? jsonData['status'] : "",
      sender: jsonData['sender'] != null ? jsonData['sender'] : "",
      order: jsonData['order'] != null ? jsonData['order'] : "",
      createdAt: jsonData['createdAt'] != null ? jsonData['createdAt'] : "",
      updatedAt: jsonData['updatedAt'] != null ? jsonData['updatedAt'] : "",
    );
  }
}

class PlayerChatListModel {
  final int? statusCode; // 200 - 204 - 400 - 404
  final List<PlayerChatModel>? items;

  PlayerChatListModel({this.statusCode, this.items});

  factory PlayerChatListModel.fromJson(Map<String, dynamic> jsonData) {
    return PlayerChatListModel(
        statusCode: jsonData['status'],
        items: jsonData['items']
            .map<PlayerChatModel>((data) => PlayerChatModel.fromJson(data))
            .toList());
  }
}
