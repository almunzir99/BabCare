class Branch {
  String? title;
  String? location;
  double? lat;
  double? long;
  double? pricePerMeter;
  int? id;
  String? createdAt;

  Branch({
    this.title,
    this.location,
    this.lat,
    this.long,
    this.pricePerMeter,
    this.id,
    this.createdAt,
  });

  Branch.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    location = json['location'];
    lat = json['lat'];
    long = json['long'];
    pricePerMeter = json['pricePerMeter'];
    id = json['id'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['location'] = location;
    data['lat'] = lat;
    data['long'] = long;
    data['pricePerMeter'] = pricePerMeter;
    data['id'] = id;
    return data;
  }
}
