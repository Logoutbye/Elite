import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationServices {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  void requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        // announcement: true,
        badge: true,
        // carPlay: true,
        // criticalAlert: true,
        // provisional: false,
        sound: true);
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('user permision granted');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('user permision granted');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.notDetermined) {
      print('user permision not determined');
    } else {
      print('user permision else case');
    }
  }
}
