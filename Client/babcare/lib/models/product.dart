import 'addon.dart';
import 'image.dart';
import 'option.dart';

class Product {
  late String? title;
  late double? price;
  late int? discount;
  late int? categoryId;
  late String? categoryName;
  late String? description;
  List<Image>? images;
  List<Option>? options;
  List<AddOn>? addOns;
  late int? id;
  DateTime? createdBy;
  bool? isFavorite;

  Product(
      {this.title,
      this.price,
      this.discount,
      this.categoryId,
      this.categoryName,
      this.description,
      this.images,
      this.options,
      this.addOns,
      this.id,
      this.isFavorite});

  Product.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    price = json['price'];
    discount = json['discount'];
    categoryId = json['categoryId'];
    categoryName = json['categoryName'];
    description = json['description'];
    isFavorite = json['isFavorite'];
    if (json['images'] != null) {
      images = <Image>[];
      json['images'].forEach((v) {
        images!.add(Image.fromJson(v));
      });
    }
    if (json['options'] != null) {
      options = <Option>[];
      json['options'].forEach((v) {
        options!.add(Option.fromJson(v));
      });
    }
    if (json['addOns'] != null) {
      addOns = <AddOn>[];
      json['addOns'].forEach((v) {
        addOns!.add(AddOn.fromJson(v));
      });
    }
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['price'] = price;
    data['discount'] = discount;
    data['categoryId'] = categoryId;
    data['categoryName'] = categoryName;
    data['description'] = description;
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    if (options != null) {
      data['options'] = options!.map((v) => v.toJson()).toList();
    }
    if (addOns != null) {
      data['addOns'] = addOns!.map((v) => v.toJson()).toList();
    }
    data['id'] = id;
    return data;
  }
}
