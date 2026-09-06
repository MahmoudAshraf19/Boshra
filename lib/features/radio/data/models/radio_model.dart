class RadioModel {
  final int id;
  final String name;
  final String url;
  final String img;

  RadioModel({
    required this.id,
    required this.name,
    required this.url,
    required this.img,
  });

  factory RadioModel.fromJson(Map<String, dynamic> json) {
    return RadioModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      url: json['url'] ?? '',
      img: json['img'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'url': url,
      'img': img,
    };
  }
}
