class OrderedAddon {
  int? id;
  int? addonIndex;
  OrderedAddon({this.id, this.addonIndex});

  OrderedAddon.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    addonIndex = json['addonIndex'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['addonIndex'] = addonIndex;
    return data;
  }
}
