import 'package:babcare/models/product.dart';
import 'package:babcare/services/general_service.dart';
import 'package:get/get.dart';

class FavoritesController extends GetxController {
  var isLoading = false.obs;
  final _service = GeneralService.instance;
  final Rx<Future?> getFavoritesAsync = Rx(null);
  RxList<Product> favList = RxList([]);
  Future getFavorites() async {
    try {
      isLoading.value = true;
      favList.value = await _service.getFavorites();
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      rethrow;
    }
  }

  Future addToFavorite(int productId) async {
    try {
      isLoading.value = true;
      await _service.addToFavorites(productId);
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      rethrow;
    }
  }

  Future removeFromFavorite(int productId) async {
    try {
      isLoading.value = true;
      await _service.removeFromFavorites(productId);
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      rethrow;
    }
  }
}
