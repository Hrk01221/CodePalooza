import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realpalooza/Theme/theme.dart';
import 'package:realpalooza/Theme/theme_provider.dart';
import 'package:realpalooza/firebase_options.dart';
import 'package:realpalooza/pages/notification.dart';
import 'package:realpalooza/pages/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationManager.initializeNotifications();
  NotificationManager.setNotificationListeners();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context)=>ThemeProvider(),
      child: const MyApp(),
    )
  );
}
//cc

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}

