class Game2Model {
  final int? statusCode;
  final String? sId;
  final String? title;
  final int? iV;

  Game2Model({
    this.statusCode,
    this.sId,
    this.title,
    this.iV,
  });

  factory Game2Model.fromJson(Map<String, dynamic> jsonData) {
    return Game2Model(
      statusCode: jsonData['status_code'],
      sId: jsonData['_id'] != null ? jsonData['_id'] : "",
      title: jsonData['title'] != null ? jsonData['title'] : "",
      iV: jsonData['__v'] != null ? jsonData['__v'] : "",
    );
  }
}

class Game2ListModel {
  final int? statusCode; // 200 - 204 - 400 - 404
  final List<Game2Model>? items;

  Game2ListModel({this.statusCode, this.items});

  factory Game2ListModel.fromJson(Map<String, dynamic> jsonData) {
    return Game2ListModel(
        statusCode: jsonData['status'],
        items: jsonData['items']
            .map<Game2Model>((data) => Game2Model.fromJson(data))
            .toList());
  }
}
