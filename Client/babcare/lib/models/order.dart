import 'package:babcare/models/branch.dart';
import 'package:babcare/models/ordered_product.dart';
import 'customer.dart';
import 'delivery.dart';

class Order {
  int? id;
  double? lat;
  double? long;
  String? location;
  int? paymentType;
  List<OrderedProduct?>? products;
  int? deliveryId;
  Delivery? delivery;
  int? total;
  String? createdAt;
  int? customerId;
  Customer? customer;
  int? branchId;
  Branch? branch;
  Order(
      {this.lat,
      this.long,
      this.location,
      this.paymentType,
      this.products,
      this.branch,
      this.branchId,
      this.createdAt,
      this.customer,
      this.customerId,
      this.delivery,
      this.id,
      this.deliveryId,
      this.total});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lat = json['lat'];
    long = json['long'];
    location = json['location'];
    paymentType = json['paymentType'];
    branch = (json['branch'] == null) ? null : Branch.fromJson(json['branch']);
    branchId = json['branchId'];
    customer = (json['customer'] == null)
        ? null
        : Customer().fromJson(json['customer']);
    customerId = json['customerId'];
    total = json['total'];
    createdAt = json['createdAt'];
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
