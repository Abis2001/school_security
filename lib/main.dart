import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_security/services/notifications/notification.dart';
import 'package:school_security/view/home.dart';
import 'package:school_security/view/login.dart';
import 'package:school_security/view/register.dart';
import 'package:school_security/viewmodel/auth.dart';
import 'utils/utils.dart';
import 'package:school_security/view/splash.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
      final notificationManager = NotificationManager();
      await notificationManager.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>Auth()),
      ],
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'School Security',    
      theme: ThemeData(
        fontFamily: 'OpenSans',
        primarySwatch: Colors.blue,
        colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: Colors.blueAccent,
        onPrimary: Colors.white,
        secondary: Colors.black,
        onSecondary: Colors.black38,
        background: Colors.white,
        error: Colors.red,
        onError: Colors.red,
        onBackground: Colors.white,
        surface: Colors.red,
        onSurface: Colors.grey
        )
      ),
      routes: {
        Routes.home     :     (context)=>  const HomeScreen(),
        Routes.login    :     (context)=>  const LoginScreen(),
        Routes.register :     (context)=>  const Register()
      },
      home: const SplashScreen(),
    );
  }
}