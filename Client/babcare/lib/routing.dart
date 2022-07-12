import 'package:babcare/views/pages/checkout/checkout.dart';
import 'package:babcare/views/pages/home/home.dart';
import 'package:babcare/views/pages/account/account.dart';
import 'package:babcare/views/pages/cart/cart.dart';
import 'package:babcare/views/pages/categories/categories.dart';
import 'package:babcare/views/pages/intro/intro.dart';
import 'package:babcare/views/pages/location_picker/location_picker.dart';
import 'package:babcare/views/pages/login/login.dart';
import 'package:babcare/views/pages/notifications/notifications_page.dart';
import 'package:babcare/views/pages/order_detail/order_detail.dart';
import 'package:babcare/views/pages/order_tracking/order_tracking.dart';
import 'package:babcare/views/pages/orders/orders.dart';
import 'package:babcare/views/pages/product_detail/product_detail.dart';
import 'package:babcare/views/pages/search/search.dart';
import 'package:babcare/views/pages/signup/signup.dart';
import 'package:babcare/views/pages/splash_screen/splash_screen.dart';
import 'package:get/get.dart';

final routes = [
  GetPage(name: "/home", page: () => const HomePage()),
  GetPage(name: "/intro", page: () => const IntroPage()),
  GetPage(name: "/splash_screen", page: () => const SplashScreenPage()),
  GetPage(name: "/login", page: () => LoginPage()),
  GetPage(name: "/signup", page: () => SignupPage()),
  GetPage(name: "/account", page: () => AccountPage()),
  GetPage(name: "/orders", page: () => const OrdersPage()),
  GetPage(name: "/categories", page: () => const CategoriesPage()),
  GetPage(name: "/product_details", page: () => const ProductDetailPage()),
  GetPage(name: "/search", page: () => SearchPage()),
  GetPage(name: "/cart", page: () => const CartPage()),
  GetPage(name: "/checkout", page: () => const CheckOutPage()),
  GetPage(name: "/location_picker", page: () => const LocationPickerPage()),
  GetPage(name: "/order_tracking", page: () => const OrderTrackingPage()),
  GetPage(name: "/notifications", page: () => const NotificationsPage()),
  GetPage(name: "/order_detail", page: () => const OrderDetailPage()),
];
