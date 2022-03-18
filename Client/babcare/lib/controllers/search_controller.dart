import 'package:babcare/models/product.dart';
import 'package:babcare/services/general_service.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  final RxList<Product> products = <Product>[].obs;
  final _service = GeneralService.instance;
  final searchValue = "".obs;
  final isLoading = false.obs;
  Future search() async {
    try {
      isLoading.value = true;
      var result = await _service.getProducts(searchValue.value);
      products.value = result;
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      rethrow;
    }
  }
}
