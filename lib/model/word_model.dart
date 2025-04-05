class WordModel {
  final int id;
  final String eng;
  final String myan;
  final String type;
  final int? favourite;
  WordModel({
    required this.id,
    required this.eng,
    required this.myan,
    required this.type,
    required this.favourite,
  });
  factory WordModel.fromMap(Map<String, dynamic> json) {
    int id = json['id'];
    String eng = json['eng'];
    String myan = json['myan'];
    String type = json['type'];
    int? favourite = json['favourite'];
    myan = myan.split('~~~').first;
    return WordModel(
      id: id,
      eng: eng,
      myan: myan,
      type: type,
      favourite: favourite,
    );
  }
}
