import 'package:carousel_slider/carousel_controller.dart';
import 'package:get/get.dart';

class ProductsController extends GetxController {
  final carouselController = CarouselController();
  final _currentCarouselIndex = 0.obs;
  int get currentCarouselIndex => _currentCarouselIndex.value;
  set currentCarouselIndex(value) => _currentCarouselIndex.value = value;
  final RxList<int> _optionsIds = <int>[].obs;
  List<int> get optionsList => _optionsIds;
  bool containsOption(int id) => _optionsIds.contains(id);
}
