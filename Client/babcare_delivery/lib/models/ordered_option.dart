class OrderedOption {
  int? id;
  int? optionIndex;
  int? optionValueIndex;

  OrderedOption({this.optionIndex, this.optionValueIndex});

  OrderedOption.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    optionIndex = json['optionIndex'];
    optionValueIndex = json['optionValueIndex'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['optionIndex'] = optionIndex;
    data['optionValueIndex'] = optionValueIndex;
    return data;
  }
}
