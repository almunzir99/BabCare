import 'package:babcare/views/pages/account.dart';
import 'package:babcare/views/pages/cart.dart';
import 'package:babcare/views/pages/categories.dart';
import 'package:babcare/views/pages/home.dart';
import 'package:babcare/views/pages/intro.dart';
import 'package:babcare/views/pages/login.dart';
import 'package:babcare/views/pages/orders.dart';
import 'package:babcare/views/pages/product_detail.dart';
import 'package:babcare/views/pages/search.dart';
import 'package:babcare/views/pages/signup.dart';
import 'package:babcare/views/pages/splash_screen.dart';
import 'package:babcare/views/pages/tabbar.dart';
import 'package:get/get.dart';

final routes = [
  GetPage(name: "/intro", page: () => const IntroPage()),
  GetPage(name: "/splash_screen", page: () => const SplashScreenPage()),
  GetPage(name: "/login", page: () => const LoginPage()),
  GetPage(name: "/signup", page: () => const SignupPage()),
  GetPage(name: "/tabbar", page: () => const TabBar()),
  GetPage(name: "/home", page: () => const HomePage()),
  GetPage(name: "/account", page: () => const AccountPage()),
  GetPage(name: "/orders", page: () => const OrdersPage()),
  GetPage(name: "/categories", page: () => const CategoriesPage()),
  GetPage(name: "/product_details", page: () => const ProductDetailPage()),
  GetPage(name: "/search", page: () => const SearchPage()),
  GetPage(name: "/cart", page: () => const CartPage()),
];
