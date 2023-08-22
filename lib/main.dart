import 'package:ezeehome_webview/Controllers/firebase_notification.dart';
import 'package:ezeehome_webview/Controllers/initlize_app.dart';
import 'package:ezeehome_webview/Screens/Home.dart';
import 'package:ezeehome_webview/Screens/boarding.dart';
import 'package:ezeehome_webview/services/notification_services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'changes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseNotificationHandling().initNotification();
  await InitilizeApp.callFunctions();
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //   // systemNavigationBarColor: Colors.transparent,
  //   // statusBarColor: Colors.transparent,
  // ));
  final prefs = await SharedPreferences.getInstance();
  final showHome = prefs.getBool('showHome') ?? false;
  runApp(MyApp(showHome: showHome));
  // runApp(MyApp());
}

class MyApp extends StatefulWidget {
  final bool showHome;
  MyApp({Key? key, required this.showHome}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final firebaseMessaging = FirebaseMessaging.instance;

  Future<void> firebaseOnBackgroundMessage(RemoteMessage message) async {
    print("Handling a background message: ${message.messageId}");
  }

  @override
  void initState() {
    NotificationServices().requestNotificationPermission();
    firebaseMessaging.getToken().then((value) {
      print("bilal FirebaseMessagingtoken ::${value}");
    });
    FirebaseMessaging.onBackgroundMessage(firebaseOnBackgroundMessage);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print(
          'bilal Foreground message received: ${message.notification?.title}');
      print('bilal Received foreground message: ${message.notification?.body}');

      // Handle the foreground message here
      // You can show a dialog, update the app UI, or perform any required action
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('bilal Notification clicked!');
      // Handle the notification click event here
      // You can navigate to a specific screen or perform any required action
    });

    // TODO: implement initState
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: Changes.AppTitle,
        theme: ThemeData(primarySwatch: Colors.pink, useMaterial3: true),
        home: widget.showHome ? Home() : OnBordingScreen());
  }
}
