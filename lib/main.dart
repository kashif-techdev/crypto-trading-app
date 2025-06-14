import 'package:firebases/View/io.dart';
import 'package:firebases/View/splash.dart';
import 'package:flutter/material.dart';
import 'package:firebases/widgets/button.dart';
import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'auth/login_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: IO(),
    );
  }
}
