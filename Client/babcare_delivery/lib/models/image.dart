class Image {
  String? path;
  int? id;
  DateTime? createdAt;
  DateTime? lastUpdate;

  Image({
    this.path,
    this.id,
    this.createdAt,
    this.lastUpdate,
  });

  Image.fromJson(Map<String, dynamic> json) {
    path = json['path'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['path'] = path;
    data['id'] = id;
    data['createdAt'] = createdAt;
    data['lastUpdate'] = lastUpdate;
    return data;
  }
}
