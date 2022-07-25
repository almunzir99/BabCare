class ApiConstants {
  static const String baseUrl = "https://192.168.43.42:5001/";
  static const String baseDeliveryRoute = "/api/delivery";
  static const String authenticateRoute = "/api/delivery/authenticate";
  static const String ordersBaseRoute = "/api/orders";
  static const String completeOrder = "/api/orders/complete";
  static const String notificationHubURL = "notification-hub";
  static const String notificationBaseRoute =
      "$baseDeliveryRoute/notifications";
}
