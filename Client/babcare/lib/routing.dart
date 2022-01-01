import 'package:babcare/views/pages/bank_accounts_page.dart';
import 'package:babcare/views/pages/home.dart';
import 'package:babcare/views/pages/account.dart';
import 'package:babcare/views/pages/cart.dart';
import 'package:babcare/views/pages/categories.dart';
import 'package:babcare/views/pages/intro.dart';
import 'package:babcare/views/pages/login.dart';
import 'package:babcare/views/pages/order_detail.dart';
import 'package:babcare/views/pages/order_tracking.dart';
import 'package:babcare/views/pages/orders.dart';
import 'package:babcare/views/pages/product_detail.dart';
import 'package:babcare/views/pages/search.dart';
import 'package:babcare/views/pages/signup.dart';
import 'package:babcare/views/pages/splash_screen.dart';
import 'package:get/get.dart';

final routes = [
  GetPage(name: "/home", page: () => const HomePage()),
  GetPage(name: "/intro", page: () => const IntroPage()),
  GetPage(name: "/splash_screen", page: () => const SplashScreenPage()),
  GetPage(name: "/login", page: () => const LoginPage()),
  GetPage(name: "/signup", page: () => const SignupPage()),
  GetPage(name: "/account", page: () => const AccountPage()),
  GetPage(name: "/orders", page: () => const OrdersPage()),
  GetPage(name: "/categories", page: () => const CategoriesPage()),
  GetPage(name: "/product_details", page: () => const ProductDetailPage()),
  GetPage(name: "/search", page: () => const SearchPage()),
  GetPage(name: "/cart", page: () => const CartPage()),
  GetPage(name: "/banks", page: () => const BankAccountsPage()),
  GetPage(name: "/order_detail", page: () => const OrderDetailPage()),
  GetPage(name: "/order_tracking", page: () => const OrderTrackingPage()),
];
