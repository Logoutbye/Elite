import 'package:ezeehome_webview/Controllers/firebase_notification.dart';
import 'package:ezeehome_webview/Controllers/initlize_app.dart';
import 'package:ezeehome_webview/Screens/Home.dart';
import 'package:ezeehome_webview/Screens/boarding.dart';
import 'package:ezeehome_webview/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

class MyApp extends StatelessWidget {
  final bool showHome;
  MyApp({Key? key, required this.showHome}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: Changes.AppTitle,
        theme: ThemeData(primarySwatch: Colors.pink, useMaterial3: true),
        home: showHome ? Home() : OnBordingScreen());
  }
}
