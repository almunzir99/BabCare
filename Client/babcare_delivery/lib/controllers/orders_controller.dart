import 'package:babcare_delivery/models/order.dart';
import 'package:babcare_delivery/services/orders_service.dart';
import 'package:get/get.dart';

class OrdersController extends GetxController {
  RxList<Order> orders = RxList([]);
  final _service = OrdersService.instance;
  Order? currentOrder;
  Rx<Future?> getOrderAsync = Rx(null);
  Future getOrders(int status) async {
    try {
      orders.value = await _service.getMyOrder(status);
    } catch (e) {
      rethrow;
    }
  }

  Future completeOrder(int orderId) async {
    try {
      await _service.completeOrder(orderId);
    } catch (e) {
      rethrow;
    }
  }
}
