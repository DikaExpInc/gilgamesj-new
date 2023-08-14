class StageModel {
  int? statusCode;
  DataGame? dataGame;
  int? totalPlayer;
  String? sId;
  String? background;
  String? objective;
  String? model;
  String? title;
  String? description;
  int? lockCode;
  int? orderNumber;
  int? timer;
  String? createdAt;
  String? updatedAt;

  StageModel({
    this.statusCode,
    this.dataGame,
    this.totalPlayer,
    this.sId,
    this.background,
    this.objective,
    this.model,
    this.title,
    this.description,
    this.lockCode,
    this.orderNumber,
    this.timer,
    this.createdAt,
    this.updatedAt,
  });

  factory StageModel.fromJson(Map<String, dynamic> json) {
    return StageModel(
      statusCode: json['status_code'],
      dataGame: json['data_game'] != null
          ? new DataGame.fromJson(json['data_game'])
          : null,
      totalPlayer: json['total_player'] != null ? json['total_player'] : 0,
      sId: json['_id'] != null ? json['_id'] : "",
      background: json['background'] != null ? json['background'] : "",
      objective: json['objective'] != null ? json['objective'] : "",
      model: json['model'] != null ? json['model'] : "",
      title: json['title'] != null ? json['title'] : "",
      description: json['description'] != null ? json['objective'] : "",
      lockCode: json['lock_code'] != null ? json['lock_code'] : 0,
      orderNumber: json['order_number'] != null ? json['order_number'] : 0,
      timer: json['timer'] != null ? json['timer'] : 0,
      createdAt: json['createdAt'] != null ? json['createdAt'] : "",
      updatedAt: json['updatedAt'] != null ? json['updatedAt'] : "",
    );
  }
}

class DataGame {
  List<String>? camera;
  List<String>? chat;
  List<String>? contact;
  List<String>? galleryPhoto;
  List<String>? galleryVideo;
  List<String>? map;
  List<String>? news;
  List<String>? phone;
  List<String>? socialMedia;

  DataGame(
      {this.camera,
      this.chat,
      this.contact,
      this.galleryPhoto,
      this.galleryVideo,
      this.map,
      this.news,
      this.phone,
      this.socialMedia});

  DataGame.fromJson(Map<String, dynamic> json) {
    camera = json['camera'].cast<String>();
    chat = json['chat'].cast<String>();
    contact = json['contact'].cast<String>();
    galleryPhoto = json['gallery_photo'].cast<String>();
    galleryVideo = json['gallery_video'].cast<String>();
    map = json['map'].cast<String>();
    news = json['news'].cast<String>();
    phone = json['phone'].cast<String>();
    socialMedia = json['social_media'].cast<String>();
  }
}
