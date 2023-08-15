
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseNotificationHandling {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission();
    final FCMToken = await _firebaseMessaging.getToken();
    print('FCMToken:$FCMToken');

    //background
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }
}

Future<void> handleBackgroundMessage(RemoteMessage remoteMessage) async {
  print(':::Notification Title${remoteMessage.notification?.title}');
  print(':::Notification Body${remoteMessage.notification?.body}');
  print(':::Payload ${remoteMessage.data}');
}
