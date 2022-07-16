import 'package:babcare_delivery/constants/api_constants.dart';
import 'package:babcare_delivery/interceptors/app_interceptors.dart';
import 'package:babcare_delivery/models/order.dart';
import 'package:dio/dio.dart';

class OrdersService {
  Dio dio = Dio();
  OrdersService._privateConstructor() {
    dio.interceptors.add(AppInterceptors());
  }
  static final OrdersService instance = OrdersService._privateConstructor();
  Future<List<Order>> getMyOrder(int status) async {
    try {
      var response = await dio.get(
          "${ApiConstants.ordersBaseRoute}/delivery/me?status=$status",
          options: Options(headers: {"requiresToken": true}));
      if (response.statusCode == 200) {
        var orders = <Order>[];
        var jsonOrders = response.data['data'] as List;
        for (var order in jsonOrders) {
          orders.add(Order.fromJson(order));
        }
        return orders;
      } else {
        throw "Request failed with statusCode ${response.statusCode} and message ${response.data}";
      }
    } catch (e) {
      rethrow;
    }
  }

  Future completeOrder(int orderId) async {
    var response = await dio.post(ApiConstants.completeOrder,
        data: {"orderId": orderId},
        options: Options(headers: {"requiresToken": true}));
    if (response.statusCode != 200) {
      throw "Request failed with statusCode ${response.statusCode} and message ${response.data}";
    }
  }
}
