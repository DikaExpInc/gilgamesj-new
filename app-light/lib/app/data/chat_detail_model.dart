class ChatDetailModel {
  final int? statusCode;
  final String? sId;
  final String? title;
  final String? status;
  final String? sender;
  final int? order;
  final String? chatFamilyId;
  final String? chatSiblingId;
  final String? createdAt;
  final String? updatedAt;

  ChatDetailModel({
    this.statusCode,
    this.sId,
    this.title,
    this.status,
    this.sender,
    this.order,
    this.chatFamilyId,
    this.chatSiblingId,
    this.createdAt,
    this.updatedAt,
  });

  factory ChatDetailModel.fromJson(Map<String, dynamic> jsonData) {
    return ChatDetailModel(
      statusCode: jsonData['status_code'],
      sId: jsonData['_id'] != null ? jsonData['_id'] : "",
      title: jsonData['title'] != null ? jsonData['title'] : "",
      status: jsonData['status'] != null ? jsonData['status'] : "",
      sender: jsonData['sender'] != null ? jsonData['sender'] : "",
      order: jsonData['order'] != null ? jsonData['order'] : "",
      chatFamilyId:
          jsonData['chat_family_id'] != null ? jsonData['chat_family_id'] : "",
      chatSiblingId: jsonData['chat_sibling_id'] != null
          ? jsonData['chat_sibling_id']
          : "",
      createdAt: jsonData['createdAt'] != null ? jsonData['createdAt'] : "",
      updatedAt: jsonData['updatedAt'] != null ? jsonData['updatedAt'] : "",
    );
  }
}

class ChatDetailListModel {
  final int? statusCode; // 200 - 204 - 400 - 404
  final List<ChatDetailModel>? items;

  ChatDetailListModel({this.statusCode, this.items});

  factory ChatDetailListModel.fromJson(Map<String, dynamic> jsonData) {
    return ChatDetailListModel(
        statusCode: jsonData['status'],
        items: jsonData['items']
            .map<ChatDetailModel>((data) => ChatDetailModel.fromJson(data))
            .toList());
  }
}
