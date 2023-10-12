class Game5Model {
  final int? statusCode;
  final String? sId;
  final String? title;
  final int? iV;

  Game5Model({
    this.statusCode,
    this.sId,
    this.title,
    this.iV,
  });

  factory Game5Model.fromJson(Map<String, dynamic> jsonData) {
    return Game5Model(
      statusCode: jsonData['status_code'],
      sId: jsonData['_id'] != null ? jsonData['_id'] : "",
      title: jsonData['title'] != null ? jsonData['title'] : "",
      iV: jsonData['__v'] != null ? jsonData['__v'] : "",
    );
  }
}

class Game5ListModel {
  final int? statusCode; // 200 - 204 - 400 - 404
  final List<Game5Model>? items;

  Game5ListModel({this.statusCode, this.items});

  factory Game5ListModel.fromJson(Map<String, dynamic> jsonData) {
    return Game5ListModel(
        statusCode: jsonData['status'],
        items: jsonData['items']
            .map<Game5Model>((data) => Game5Model.fromJson(data))
            .toList());
  }
}
