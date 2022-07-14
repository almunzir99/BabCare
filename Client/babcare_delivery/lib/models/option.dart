import 'option_value.dart';

class Option {
  String? title;
  List<OptionValue>? values;
  int? id;

  Option({
    this.title,
    this.values,
    this.id,
  });

  Option.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    if (json['values'] != null) {
      values = <OptionValue>[];
      json['values'].forEach((v) {
        values!.add(OptionValue.fromJson(v));
      });
    }
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    if (values != null) {
      data['values'] = values!.map((v) => v.toJson()).toList();
    }
    data['id'] = id;
    return data;
  }
}
