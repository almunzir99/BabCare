import 'package:babcare/models/customer.dart';
import 'package:babcare/models/notification.dart';
import 'package:babcare/services/auth_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final _authService = AuthService.instance;
  Rx<Customer?> currentCustomer = Rx<Customer?>(null);
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
      currentCustomer.value = result;
      notifications.value = await _authService.getNotifications();
    } catch (e) {
      isButtonLoading.value = false;

      rethrow;
    }
  }

  Future<Customer> register(Customer customer) async {
    try {
      isButtonLoading.value = true;
      var result = await _authService.register(customer);
      var storage = const FlutterSecureStorage();
      await storage.write(key: "token", value: result.token);
      await storage.write(key: "user_id", value: "${result.id}");
      isButtonLoading.value = false;
      currentCustomer.value = result;
      return result;
    } catch (e) {
      isButtonLoading.value = false;
      rethrow;
    }
  }

  Future<Customer> updateProfile(int id, Customer customer) async {
    try {
      isButtonLoading.value = true;
      var result = await _authService.updateProfile(id, customer);
      isButtonLoading.value = false;
      currentCustomer.value = result;
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
