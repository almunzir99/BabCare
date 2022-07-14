import 'package:babcare_delivery/models/delivery.dart';
import 'package:babcare_delivery/models/notification.dart';
import 'package:babcare_delivery/services/auth_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final _authService = AuthService.instance;
  Rx<Delivery?> currentDelivery = Rx<Delivery?>(null);
  RxList<Notification> notifications = RxList([]);
  final isButtonLoading = false.obs;
  final pageLoading = false.obs;
  Future authenticate(String phone, String password) async {
    try {
      isButtonLoading.value = true;
      var result = await _authService.authenticate(phone, password);
      var storage = const FlutterSecureStorage();
      await storage.write(key: "token", value: result.token);
      await storage.write(key: "user_id", value: "${result.id}");
      isButtonLoading.value = false;
      currentDelivery.value = result;
      notifications.value = await _authService.getNotifications();
    } catch (e) {
      isButtonLoading.value = false;

      rethrow;
    }
  }

  Future<Delivery> updateProfile(int id, Delivery delivery) async {
    try {
      isButtonLoading.value = true;
      var result = await _authService.updateProfile(id, delivery);
      isButtonLoading.value = false;
      currentDelivery.value = result;
      return result;
    } catch (e) {
      isButtonLoading.value = false;
      rethrow;
    }
  }

  Future readNotifications() async {
    try {
      pageLoading.value = true;
      await _authService.readNotification();
      for (var notification in notifications) {
        notification.read = true;
      }
      pageLoading.value = false;
    } catch (e) {
      pageLoading.value = false;
      rethrow;
    }
  }
}
