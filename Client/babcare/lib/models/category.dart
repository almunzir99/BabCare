import 'package:babcare/models/image.dart';
import 'package:babcare/models/product.dart';

import 'offer.dart';

class Category {
  int? id;
  String? title;
  Image? image;
  Offer? offer;
  String? icon;
  List<Product>? products = [];

  Category({this.title, this.id, this.image, this.icon});
  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'] != null ? Image.fromJson(json['image']) : null;
    offer = json['offer'] != null ? Offer.fromJson(json['offer']) : null;
    if (json['products'] != null) {
      products = <Product>[];
      json['products'].forEach((v) {
        products!.add(Product.fromJson(v));
      });
    }
  }
}

List<Category> categories = [
  Category(id: 1, title: "بيتزا", icon: "assets/temp/categories/pizza.png"),
  Category(id: 1, title: "بيرقر", icon: "assets/temp/categories/burger.png"),
  Category(
      id: 1, title: "دجاج بروست", icon: "assets/temp/categories/broasted.png"),
  Category(
      id: 1, title: "أيس كريم", icon: "assets/temp/categories/ice-cream.png"),
  Category(id: 1, title: "عصير", icon: "assets/temp/categories/juice.png"),
];
