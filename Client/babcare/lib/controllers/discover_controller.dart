import 'package:carousel_slider/carousel_controller.dart';
import 'package:get/get.dart';

class DiscoverController extends GetxController {
  final carouselController = CarouselController();
  final _currentCarouselIndex = 0.obs;
  final _selectedCategoryIndex = 0.obs;
  get selectedCategoryIndex => _selectedCategoryIndex.value;
  get currentCarouselIndex => _currentCarouselIndex.value;
  onCarouselSlide(int index) {
    _currentCarouselIndex.value = index;
  }

  selectCategory(int index) {
    _selectedCategoryIndex.value = index;
  }
}
