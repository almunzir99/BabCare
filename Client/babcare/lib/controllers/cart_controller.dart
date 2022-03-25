import 'package:babcare/models/order.dart';
import 'package:babcare/models/ordered_product.dart';
import 'package:babcare/services/general_service.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final RxList<OrderedProduct?> _cart = RxList([]);
  RxList<OrderedProduct?> get cart => _cart;
  final Rx<double> total = 0.0.obs;
  Rx<double> lat = 0.0.obs, long = 0.0.obs, deliveryPrice = 0.0.obs;
  Rx<String> location = ''.obs;
  Rx<int> paymentType = 0.obs; // 0 for cash & 1 for online payment
  final isButtonLoading = false.obs;
  final _service = GeneralService.instance;
  void addToCart(OrderedProduct product) {
    if (_cart.contains(product)) return;
    _cart.add(product);
    _calculateTotal();
    _cart.refresh();
  }

  void removeFormCart(int id) {
    var target = findProduct(id);
    if (target != null) {
      _cart.remove(target);
      _calculateTotal();
      _cart.refresh();
    }
  }

  void increateAmount(int id) {
    var target = findProduct(id);
    if (target != null) target.amount++;
    _calculateTotal();
    _cart.refresh();
  }

  void decreateAmount(int id) {
    var target = findProduct(id);
    if (target != null && target.amount > 1) target.amount--;
    _calculateTotal();
    _cart.refresh();
  }

  OrderedProduct? findProduct(int id) {
    var target = _cart.singleWhere((element) => element!.productId == id,
        orElse: () => null);
    _cart.refresh();

    return target;
  }

  void _calculateTotal() {
    total.value = 0;
    for (var element in cart) {
      _calculateProductTotal(element!);
      total.value += element.total!;
    }
  }

  Future<Order> createOrder() async {
    try {
      isButtonLoading.value = true;
      var order = Order(
          lat: lat.value,
          long: long.value,
          location: location.value,
          paymentType: paymentType.value,
          products: cart);
      var result = await _service.postOrder(order);
      isButtonLoading.value = false;
      return result;
    } catch (e) {
      isButtonLoading.value = false;
      rethrow;
    }
  }

  void _calculateProductTotal(OrderedProduct product) {
    double total = product.product!.price!;
    for (var option in product.orderedOptions!) {
      var value = product.product!.options![option.optionIndex!]
          .values![option.optionValueIndex!];
      total += value.value!;
    }
    for (var addon in product.orderedAddons!) {
      var value = product.product!.addOns![addon.addonIndex!];
      total += value.price!;
    }
    total *= product.amount;
    product.total = total;
  }
}
