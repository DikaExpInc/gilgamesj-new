class TheaterSeatModel {
  final int? statusCode;
  final Map<String, dynamic>? dataJson;

  TheaterSeatModel({
    this.statusCode,
    this.dataJson,
  });

  factory TheaterSeatModel.fromJson(Map<String, dynamic> jsonData) {
    return TheaterSeatModel(
      statusCode: jsonData['status_code'],
      dataJson: jsonData['data'],
    );
  }
}
