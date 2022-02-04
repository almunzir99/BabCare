class AddOn {
  String? title;
  int? price;
  int? id;
  DateTime? createdAt;
  DateTime? lastUpdate;

  AddOn({
    this.title,
    this.price,
    this.id,
    this.createdAt,
    this.lastUpdate,
  });

  AddOn.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    price = json['price'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['price'] = price;
    data['id'] = id;
    return data;
  }
}
