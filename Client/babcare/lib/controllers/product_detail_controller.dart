import 'package:babcare/models/ordered_addons.dart';
import 'package:babcare/models/ordered_option.dart';
import 'package:babcare/models/ordered_product.dart';
import 'package:babcare/models/product.dart';
import 'package:babcare/services/general_service.dart';
import 'package:get/get.dart';

class ProductDetailController extends GetxController {
  final product = Rx<Product?>(null);
  final _service = GeneralService.instance;
  final orderedProduct = Rx<OrderedProduct?>(null);
  final _currentCarouselIndex = 0.obs;
  int get currentCarouselIndex => _currentCarouselIndex.value;
  set currentCarouselIndex(value) => _currentCarouselIndex.value = value;
  final RxList<int> _optionsIds = <int>[].obs;
  List<int> get optionsList => _optionsIds;

  Future getProduct(int id) async {
    try {
      product.value = await _service.getProduct(id);
      _initializeOrderedProduct(product.value!);
    } catch (e) {
      rethrow;
    }
  }

  void increaseAmount() {
    orderedProduct.value!.amount++;
    _calculateProductTotal();
    orderedProduct.refresh();
  }

  void decreaseAmount() {
    if (orderedProduct.value!.amount > 0) {
      orderedProduct.value!.amount--;
      _calculateProductTotal();
      orderedProduct.refresh();
    }
  }

  void selectedOption(int optionIndex, int valueIndex) {
    orderedProduct.value!.orderedOptions![optionIndex].optionValueIndex =
        valueIndex;
    _calculateProductTotal();
    orderedProduct.refresh();
  }

  void addAddon(int addOnIndex) {
    var result = findAddon(addOnIndex);
    if (result.addonIndex == -1) {
      orderedProduct.value!.orderedAddons!
          .add(OrderedAddon(addonIndex: addOnIndex));
      _calculateProductTotal();
      orderedProduct.refresh();
    }
  }

  void removeAddon(int addOnIndex) {
    var result = findAddon(addOnIndex);
    if (result.id != -1) {
      orderedProduct.value!.orderedAddons!.remove(result);
      _calculateProductTotal();
      orderedProduct.refresh();
    }
  }

  bool isAddonAdded(int addOnIndex) {
    var result = findAddon(addOnIndex);
    return result.addonIndex == -1 ? false : true;
  }

  OrderedAddon findAddon(int addOnIndex) {
    var result = orderedProduct.value!.orderedAddons!.singleWhere(
        (element) => element.addonIndex == addOnIndex,
        orElse: () => OrderedAddon(addonIndex: -1));
    return result;
  }

  void _initializeOrderedProduct(Product product) {
    orderedProduct.value = OrderedProduct();
    orderedProduct.value!.orderedAddons = <OrderedAddon>[];
    var options = <OrderedOption>[];
    for (var element in product.options!) {
      var index = product.options!.indexOf(element);
      options.add(OrderedOption(optionIndex: index, optionValueIndex: 0));
    }
    orderedProduct.value!.orderedOptions = options;
    orderedProduct.value!.productId = product.id!;
    orderedProduct.value!.product = product;
    _calculateProductTotal();
  }

  void _calculateProductTotal() {
    double total = product.value!.price!;
    for (var option in orderedProduct.value!.orderedOptions!) {
      var value = product.value!.options![option.optionIndex!]
          .values![option.optionValueIndex!];
      total += value.value!;
    }
    for (var addon in orderedProduct.value!.orderedAddons!) {
      var value = product.value!.addOns![addon.addonIndex!];
      total += value.price!;
    }
    total *= orderedProduct.value!.amount;
    orderedProduct.value!.total = total;
  }
}
