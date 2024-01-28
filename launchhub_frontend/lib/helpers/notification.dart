import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:launchhub_frontend/helpers/navigator.dart';

void handleMessages(RemoteMessage? message) {
  if (message == null) return;
  FirebaseMessaging.onMessage.listen((message) {
    print('Handling a foreground message ${message.notification!.body}');
    navigatorKey.currentState!.pushNamed('/HireTalent');
  });
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    navigatorKey.currentState?.pushNamed('/HireTalent');
  });
}

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    FirebaseMessaging.onMessage.listen(_handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
    _initializeLocalNotifications();

    final fcmToken = await _firebaseMessaging.getToken();
    print('FCM Token: $fcmToken');
  }

  void _handleMessage(RemoteMessage message) {
    print('Handling a message ${message.notification?.body}');
    if (message.notification != null) {
      _displayNotification(message);
    }
  }

  Future<void> _initializeLocalNotifications() async {
    const androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
    );
    await _localNotifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        await _selectNotification(response.payload);
      },
    );
  }

  Future _selectNotification(String? payload) async {
    navigatorKey.currentState?.pushNamed('/HireTalent');
  }

  Future<void> _displayNotification(RemoteMessage message) async {
    const notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        'channel_id',
        'channel_name',
        channelDescription: 'channel_description',
        importance: Importance.max,
        priority: Priority.high,
      ),
    );

    await _localNotifications.show(
      0,
      message.notification!.title,
      message.notification!.body,
      notificationDetails,
      payload: message.data['route'],
    );
  }
}
