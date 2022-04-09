import 'package:babcare/controllers/auth_controller.dart';
import 'package:babcare/models/notification.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:signalr_core/signalr_core.dart';

import '../constants/api_constants.dart';

class SignalRService {
  HubConnection? connection;
  SignalRService._privateConstructor();
  Future initializeConnection() async {
    var fss = const FlutterSecureStorage();
    var userId = await fss.read(key: "user_id");
    connection = HubConnectionBuilder()
        .withUrl(
            "${ApiConstants.baseUrl}${ApiConstants.notificationHubURL}?userId=$userId&type=customer",
            HttpConnectionOptions(
              logging: (level, message) => print(message),
            ))
        .build();
    await connection!.start()!.catchError((err) {});
  }

  onNotificationRecieved(void Function(Notification notification) callback) {
    if (connection == null) throw "Connection isn't initialized yet";
    connection!.on("recieveNotification", (result) {
      var notification = Notification.fromJson(result![0]);
      callback(notification);
    });
  }

  static final instance = SignalRService._privateConstructor();
}
