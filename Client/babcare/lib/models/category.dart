import 'package:babcare/models/product.dart';

class Category {
  int id;
  String name;
  String image;
  String icon;
  List<Product>? products = [];
  Category(this.id, this.name,
      {this.icon = "", this.image = "", this.products});
}

List<Category> categories = [
  Category(1, "بيتزا", icon: "assets/temp/categories/pizza.png"),
  Category(1, "بيرقر", icon: "assets/temp/categories/burger.png"),
  Category(1, "دجاج بروست", icon: "assets/temp/categories/broasted.png"),
  Category(1, "أيس كريم", icon: "assets/temp/categories/ice-cream.png"),
  Category(1, "عصير", icon: "assets/temp/categories/juice.png"),
];
