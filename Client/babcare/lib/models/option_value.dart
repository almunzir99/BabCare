import 'package:babcare/models/options.dart';

class OptionValue {
  String? title;
  int? value;
  int? id;
  DateTime? createdAt;
  DateTime? lastUpdate;

  OptionValue({
    this.title,
    this.value,
    this.id,
    this.createdAt,
    this.lastUpdate,
  });

  OptionValue.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    value = json['value'];
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
