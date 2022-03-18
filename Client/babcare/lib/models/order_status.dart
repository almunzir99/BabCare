import 'package:flutter/material.dart';

class OrderStatus {
  int? id;
  String? status;
  Color? color;
  OrderStatus(this.id, this.status, {this.color});
}

final List<OrderStatus> orderStats = [
  OrderStatus(1, "تم الارسال"),
  OrderStatus(1, "تم التأكيد"),
  OrderStatus(1, "تم التحضير"),
  OrderStatus(1, "قيد التوصيل"),
  OrderStatus(1, "مكتمل"),
];
