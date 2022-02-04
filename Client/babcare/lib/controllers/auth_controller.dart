import 'package:babcare/models/customer.dart';
import 'package:babcare/services/auth_service.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final _authService = AuthService.instance;
  Rx<Customer?> currentCustomer = Rx<Customer?>(null);
  final isButtonLoading = false.obs;
  Future authenticate(String phone, String password) async {
    try {
      isButtonLoading.value = true;
      var result = await _authService.authenticate(phone, password);
      isButtonLoading.value = false;
      currentCustomer.value = result;
    } catch (e) {
      isButtonLoading.value = false;

      rethrow;
    }
  }

  Future<Customer> register(Customer customer) async {
    try {
      isButtonLoading.value = true;
      var result = await _authService.register(customer);
      isButtonLoading.value = false;
      currentCustomer.value = result;
      return customer;
    } catch (e) {
      isButtonLoading.value = false;
      rethrow;
    }
  }
}
