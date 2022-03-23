import 'package:babcare/constants/api_constants.dart';
import 'package:babcare/interceptors/app_interceptors.dart';
import 'package:babcare/models/category.dart';
import 'package:babcare/models/nearest_branch_info.dart';
import 'package:babcare/models/offer.dart';
import 'package:babcare/models/product.dart';
import 'package:dio/dio.dart';

class GeneralService {
  Dio dio = Dio();
  GeneralService._privateConstructor() {
    dio.interceptors.add(AppInterceptors());
  }
  static final GeneralService instance = GeneralService._privateConstructor();
  Future<List<Offer>> getOffers() async {
    try {
      var response = await dio.get(ApiConstants.offersBaseRoute);
      if (response.statusCode == 200) {
        var data = response.data['data'] as List;
        var offers = <Offer>[];
        offers = data.map((e) => Offer.fromJson(e)).toList();
        return offers;
      } else {
        throw "Request failed with statusCode ${response.statusCode} and message ${response.data}";
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Category>> getCategories() async {
    try {
      var response = await dio.get(ApiConstants.categoriesBaseRoute);
      if (response.statusCode == 200) {
        var data = response.data['data'] as List;
        var categories = <Category>[];
        categories = data.map((e) => Category.fromJson(e)).toList();
        return categories;
      } else {
        throw "Request failed with statusCode ${response.statusCode} and message ${response.data}";
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Product>> getTopProducts() async {
    try {
      var response = await dio.get(ApiConstants.productsBaseRoute);
      if (response.statusCode == 200) {
        var data = response.data['data'] as List;
        var products = <Product>[];
        products = data.map((e) => Product.fromJson(e)).toList();
        return products;
      } else {
        throw "Request failed with statusCode ${response.statusCode} and message ${response.data}";
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Product>> getProducts(String? search) async {
    try {
      var params = {"title": search};
      var response = await dio.get(ApiConstants.productsBaseRoute,
          queryParameters: params);
      if (response.statusCode == 200) {
        var data = response.data['data'] as List;
        var products = <Product>[];
        products = data.map((e) => Product.fromJson(e)).toList();
        return products;
      } else {
        throw "Request failed with statusCode ${response.statusCode} and message ${response.data}";
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Product> getProduct(int id) async {
    try {
      var response = await dio.get("${ApiConstants.productsBaseRoute}/$id");
      if (response.statusCode == 200) {
        var product = Product.fromJson(response.data['data']);
        return product;
      } else {
        throw "Request failed with statusCode ${response.statusCode} and message ${response.data}";
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<NearestBranchInfo> getNearestBranchInfo(
      double lat, double long) async {
    try {
      var response = await dio.get(
          "${ApiConstants.ordersBaseRoute}/nearest-branch?lat=$lat&lng=$long");
      if (response.statusCode == 200) {
        var result = NearestBranchInfo.fromJson(response.data['data']);
        return result;
      } else {
        throw "Request failed with statusCode ${response.statusCode} and message ${response.data}";
      }
    } catch (e) {
      rethrow;
    }
  }
}
