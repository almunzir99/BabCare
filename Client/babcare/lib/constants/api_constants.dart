class ApiConstants {
  static const String baseUrl = "https://192.168.43.242:5001/";
  static const String baseCustomerRoute = "/api/customers";
  static const String authenticateRoute = "/api/customers/authenticate";
  static const String registerRoute = "/api/customers/register";
  static const String offersBaseRoute = "/api/offers";
  static const String categoriesBaseRoute = "/api/categories";
  static const String productsBaseRoute = "/api/products";
  static const String ordersBaseRoute = "/api/orders";
  static const String favroitesBaseRoute = "/api/customers/favorites";
  static const String notificationHubURL = "notification-hub";
  static const String notificationBaseRoute =
      "$baseCustomerRoute/notifications";
}
