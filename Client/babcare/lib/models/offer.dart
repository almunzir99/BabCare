import 'image.dart';

class Offer {
  String? title;
  Image? image;
  int? categoryId;
  String? startDate;
  String? endDate;
  int? discount;
  int? id;

  Offer(
      {this.title,
      this.image,
      this.categoryId,
      this.startDate,
      this.endDate,
      this.discount,
      this.id});

  Offer.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    image = json['image'] != null ? Image.fromJson(json['image']) : null;
    categoryId = json['categoryId'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    discount = json['discount'];
    id = json['id'];
  }
}
