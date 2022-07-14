import 'dart:convert';
import 'package:babcare_delivery/constants/api_constants.dart';
import 'package:babcare_delivery/interceptors/app_interceptors.dart';
import 'package:babcare_delivery/models/delivery.dart';
import 'package:babcare_delivery/models/notification.dart';
import 'package:dio/dio.dart';

class AuthService {
  Dio dio = Dio();
  AuthService._privateConstructor() {
    dio.interceptors.add(AppInterceptors());
  }
  static final AuthService instance = AuthService._privateConstructor();
  Future<Delivery> authenticate(String phone, String password) async {
    try {
      var body = {"phone": phone, "password": password};
      var response = await dio.post(ApiConstants.authenticateRoute,
          data: jsonEncode(body));

      if (response.statusCode == 200) {
        var delivery = Delivery().fromJson(response.data['data']);
        return delivery;
      } else {
        throw "Request failed with statusCode ${response.statusCode} and message ${response.data}";
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Delivery> updateProfile(int id, Delivery delivery) async {
    try {
      var response = await dio.put("${ApiConstants.baseDeliveryRoute}/$id",
          data: delivery.toJson(),
          options: Options(headers: {"requiresToken": true}));
      if (response.statusCode == 200) {
        var delivery = Delivery().fromJson(response.data['data']);
        return delivery;
      } else {
        throw "Request failed with statusCode ${response.statusCode} and message ${response.data}";
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Notification>> getNotifications() async {
    try {
      var response = await dio.get(ApiConstants.notificationBaseRoute,
          options: Options(headers: {"requiresToken": true}));
      if (response.statusCode == 200) {
        var data = response.data['data'] as List;
        var notifications = data.map((e) => Notification.fromJson(e)).toList();
        return notifications;
      } else {
        throw "Request failed with statusCode ${response.statusCode} and message ${response.data}";
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Notification>> readNotification() async {
    try {
      var response = await dio.get(
          "${ApiConstants.notificationBaseRoute}/unread?autoRead=true",
          options: Options(headers: {"requiresToken": true}));
      if (response.statusCode == 200) {
        var data = response.data['data'] as List;
        var notifications = data.map((e) => Notification.fromJson(e)).toList();
        return notifications;
      } else {
        throw "Request failed with statusCode ${response.statusCode} and message ${response.data}";
      }
    } catch (e) {
      rethrow;
    }
  }
}
