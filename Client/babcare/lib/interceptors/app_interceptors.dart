import 'dart:async';

import 'package:babcare/constants/api_constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AppInterceptors extends Interceptor {
  @override
  FutureOr<dynamic> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.headers.containsKey("requiresToken")) {
      options.headers.remove("requiresToken");
      var storage = const FlutterSecureStorage();
      var token = await storage.read(key: "token");
      if (token != null) {
        options.headers.addAll({"Authorization": "bearer $token"});
      }

      options.validateStatus = (int? statusCode) => statusCode! <= 500;
    }
    options.baseUrl = ApiConstants.baseUrl;
    handler.next(options);
    return options;
  }
}
