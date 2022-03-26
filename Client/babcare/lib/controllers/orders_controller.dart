import 'package:babcare/models/order.dart';
import 'package:babcare/services/general_service.dart';
import 'package:get/get.dart';

class OrdersController extends GetxController {
  RxList<Order> orders = RxList([]);
  final _service = GeneralService.instance;
  Order? currentOrder;
  Rx<Future?> getOrderAsync = Rx(null);
  Future getOrders() async {
    try {
      orders.value = await _service.getMyOrder();
    } catch (e) {
      rethrow;
    }
  }
}
