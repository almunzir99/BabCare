import 'package:babcare/models/category.dart';
import 'package:babcare/models/offer.dart';
import 'package:babcare/models/product.dart';
import 'package:babcare/services/general_service.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:get/get.dart';

class DiscoverController extends GetxController {
  final carouselController = CarouselController();
  final _currentCarouselIndex = 0.obs;
  final _selectedCategoryIndex = 0.obs;
  get selectedCategoryIndex => _selectedCategoryIndex.value;
  get currentCarouselIndex => _currentCarouselIndex.value;
  final RxList<Offer> offers = <Offer>[].obs;
  final RxList<Category> categories = <Category>[].obs;
  final RxList<Product> products = <Product>[].obs;

  final isPageLoading = false.obs;
  final _service = GeneralService.instance;
  onCarouselSlide(int index) {
    _currentCarouselIndex.value = index;
  }

  selectCategory(int index) {
    _selectedCategoryIndex.value = index;
  }

  Future loadItems() async {
    try {
      isPageLoading.value = true;
      offers.value = await _service.getOffers();
      categories.value = await _service.getCategories();
      products.value = await _service.getTopProducts();

      isPageLoading.value = false;
    } catch (e) {
      isPageLoading.value = false;
      rethrow;
    }
  }
}
