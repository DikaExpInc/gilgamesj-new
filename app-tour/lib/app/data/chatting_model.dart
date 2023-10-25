import 'dart:convert';

class Ask {
  final String tipe;
  final String pesan;
  final List<String>? jawaban;

  Ask({
    required this.tipe,
    required this.pesan,
    this.jawaban,
  });
}

class Answer {
  final String tipe;
  final String pesan;

  Answer({
    required this.tipe,
    required this.pesan,
  });
}

List<dynamic> parseJsonString(String jsonString) {
  return jsonDecode(jsonString);
}

List<Ask> parseAskList(List<dynamic> jsonList) {
  return jsonList
      .where((item) => item['tipe'] == 'ask')
      .map((item) => Ask(
            tipe: item['tipe'],
            pesan: item['pesan'],
            jawaban: item['jawaban'] != null
                ? List<String>.from(item['jawaban'])
                : null,
          ))
      .toList();
}

List<Answer> parseAnswerList(List<dynamic> jsonList) {
  return jsonList
      .where((item) => item['tipe'] == 'answer')
      .map((item) => Answer(
            tipe: item['tipe'],
            pesan: item['pesan'],
          ))
      .toList();
}
