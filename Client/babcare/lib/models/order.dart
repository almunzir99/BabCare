import 'package:babcare/models/ordered_product.dart';

class Order {
  int? id;
  double? lat;
  double? long;
  String? location;
  int? paymentType;
  List<OrderedProduct?>? products;

  Order({this.lat, this.long, this.location, this.paymentType, this.products});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lat = json['lat'];
    long = json['long'];
    location = json['location'];
    paymentType = json['paymentType'];
    if (json['products'] != null) {
      products = <OrderedProduct>[];
      json['products'].forEach((v) {
        products!.add(OrderedProduct.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['long'] = long;
    data['location'] = location;
    data['paymentType'] = paymentType;
    if (products != null) {
      data['products'] = products!.map((v) => v!.toJson()).toList();
    }
    return data;
  }
}
