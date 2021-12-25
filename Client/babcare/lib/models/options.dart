class Option {
  int? id;
  String? name;
  double? price;
  Option(this.id, this.name, this.price);
}

List<Option> options = [
  Option(1, "خيار 1", 100.0),
  Option(2, "خيار 2", 200.0),
  Option(3, "خيار 3", 300.0)
];
