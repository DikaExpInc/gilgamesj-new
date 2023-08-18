class ChatModel {
  final int? statusCode;
  final String? sId;
  final String? name;
  final String? contact_number;
  final String? profile;
  final String? createdAt;
  final String? updatedAt;

  ChatModel({
    this.statusCode,
    this.sId,
    this.name,
    this.contact_number,
    this.profile,
    this.createdAt,
    this.updatedAt, 
  });

  factory ChatModel.fromJson(Map<String, dynamic> jsonData) {
    return ChatModel(
      statusCode: jsonData['status_code'],
      sId: jsonData['_id'] != null ? jsonData['_id'] : "",
      name: jsonData['name'] != null ? jsonData['name'] : "",
      contact_number:
          jsonData['contact_number'] != null ? jsonData['contact_number'] : "",
      profile: jsonData['profile'] != null ? jsonData['profile'] : "",
      createdAt: jsonData['createdAt'] != null ? jsonData['createdAt'] : "",
      updatedAt: jsonData['updatedAt'] != null ? jsonData['updatedAt'] : "",
    );
  }
}

class ChatListModel {
  final int? statusCode; // 200 - 204 - 400 - 404
  final List<ChatModel>? items;

  ChatListModel({this.statusCode, this.items});

  factory ChatListModel.fromJson(Map<String, dynamic> jsonData) {
    return ChatListModel(
        statusCode: jsonData['status'],
        items: jsonData['items']
            .map<ChatModel>((data) => ChatModel.fromJson(data))
            .toList());
  }
}
