class SeatModel {
  final int? statusCode;
  final int? row;
  final int? col;

  SeatModel({
    this.statusCode,
    this.row,
    this.col,
  });

  factory SeatModel.fromJson(Map<String, dynamic> jsonData) {
    return SeatModel(
      statusCode: jsonData['status_code'],
      row: jsonData['row'] != null ? jsonData['row'] : 0,
      col: jsonData['col'] != null ? jsonData['col'] : 0,
    );
  }
}
