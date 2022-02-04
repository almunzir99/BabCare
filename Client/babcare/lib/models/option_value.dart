class OptionValue {
  String? title;
  double? value;
  int? id;

  OptionValue({
    this.title,
    this.value,
    this.id,
  });

  OptionValue.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    value = json['value'] * 1.0;
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['value'] = value;
    data['id'] = id;
    return data;
  }
}
