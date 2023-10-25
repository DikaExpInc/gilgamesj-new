class ContactModel {
  final int? statusCode;
  final String? sId;
  final String? name;
  final String? contact_number;
  final String? profile;
  final String? audio;
  final String? createdAt;
  final String? updatedAt;

  ContactModel({
    this.statusCode,
    this.sId,
    this.name,
    this.contact_number,
    this.profile,
    this.audio,
    this.createdAt,
    this.updatedAt,
  });

  factory ContactModel.fromJson(Map<String, dynamic> jsonData) {
    return ContactModel(
      statusCode: jsonData['status_code'],
      sId: jsonData['_id'] != null ? jsonData['_id'] : "",
      name: jsonData['name'] != null ? jsonData['name'] : "",
      contact_number:
          jsonData['contact_number'] != null ? jsonData['contact_number'] : "",
      profile: jsonData['profile'] != null ? jsonData['profile'] : "",
      audio: jsonData['audio'] != null ? jsonData['audio'] : "",
      createdAt: jsonData['createdAt'] != null ? jsonData['createdAt'] : "",
      updatedAt: jsonData['updatedAt'] != null ? jsonData['updatedAt'] : "",
    );
  }
}

class ContactListModel {
  final int? statusCode; // 200 - 204 - 400 - 404
  final List<ContactModel>? items;

  ContactListModel({this.statusCode, this.items});

  factory ContactListModel.fromJson(Map<String, dynamic> jsonData) {
    return ContactListModel(
        statusCode: jsonData['status'],
        items: jsonData['items']
            .map<ContactModel>((data) => ContactModel.fromJson(data))
            .toList());
  }
}
