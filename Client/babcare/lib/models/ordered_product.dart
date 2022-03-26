import 'package:babcare/models/ordered_option.dart';
import 'package:babcare/models/product.dart';

import 'ordered_addons.dart';

class OrderedProduct {
  int? productId;
  List<OrderedOption>? orderedOptions;
  List<OrderedAddon>? orderedAddons;
  Product? product;
  double? total;
  late int amount;
  OrderedProduct(
      {this.productId,
      this.orderedOptions,
      this.orderedAddons,
      this.total,
      this.amount = 1});

  OrderedProduct.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    amount = json['quantity'];
    total = json['total'];
    if (json['orderedOptions'] != null) {
      orderedOptions = <OrderedOption>[];
      json['orderedOptions'].forEach((v) {
        orderedOptions!.add(OrderedOption.fromJson(v));
      });
    }
    if (json['orderedAddons'] != null) {
      orderedAddons = <OrderedAddon>[];
      json['orderedAddons'].forEach((v) {
        orderedAddons!.add(OrderedAddon.fromJson(v));
      });
    }
    if (json['product'] != null) {
      product = Product.fromJson(json['product']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productId'] = productId;
    data['quantity'] = amount;
    if (orderedOptions != null) {
      data['orderedOptions'] = orderedOptions!.map((v) => v.toJson()).toList();
    }
    if (orderedAddons != null) {
      data['orderedAddons'] = orderedAddons!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
