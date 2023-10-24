class PhoneModel {
  final int? statusCode;
  final String? sId;
  final String? name;
  final String? phone_number;
  final String? profile;
  final String? audio;
  final String? createdAt;
  final String? updatedAt;

  PhoneModel({
    this.statusCode,
    this.sId,
    this.name,
    this.phone_number,
    this.profile,
    this.audio,
    this.createdAt,
    this.updatedAt,
  });

  factory PhoneModel.fromJson(Map<String, dynamic> jsonData) {
    return PhoneModel(
      statusCode: jsonData['status_code'],
      sId: jsonData['_id'] != null ? jsonData['_id'] : "",
      name: jsonData['name'] != null ? jsonData['name'] : "",
      phone_number:
          jsonData['phone_number'] != null ? jsonData['phone_number'] : "",
      profile: jsonData['profile'] != null ? jsonData['profile'] : "",
      audio: jsonData['audio'] != null ? jsonData['audio'] : "",
      createdAt: jsonData['createdAt'] != null ? jsonData['createdAt'] : "",
      updatedAt: jsonData['updatedAt'] != null ? jsonData['updatedAt'] : "",
    );
  }
}

class PhoneListModel {
  final int? statusCode; // 200 - 204 - 400 - 404
  final List<PhoneModel>? items;

  PhoneListModel({this.statusCode, this.items});

  factory PhoneListModel.fromJson(Map<String, dynamic> jsonData) {
    return PhoneListModel(
        statusCode: jsonData['status'],
        items: jsonData['items']
            .map<PhoneModel>((data) => PhoneModel.fromJson(data))
            .toList());
  }
}
