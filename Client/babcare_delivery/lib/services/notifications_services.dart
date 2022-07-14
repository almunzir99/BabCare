import 'package:babcare_delivery/models/notification.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationsService {
  NotificationsService._privateConstructor();
  static final instance = NotificationsService._privateConstructor();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  Future init() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('app_icon');
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  Future pushNotification(Notification notification) async {
    AndroidNotificationDetails _androidNotificationDetails =
        AndroidNotificationDetails(
            "${notification.id}", "${notification.title}",
            playSound: true,
            priority: Priority.high,
            importance: Importance.high);
    NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: _androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(
      0,
      '${notification.title} 🔔',
      '${notification.message}',
      platformChannelSpecifics,
      payload: '${notification.url}',
    );
  }
}
