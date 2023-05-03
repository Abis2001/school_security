import 'package:flutter/material.dart';
import 'package:school_security/view/home.dart';
import 'package:school_security/view/login.dart';
import 'package:school_security/view/register.dart';
import 'utils/utils.dart';
import 'package:school_security/view/splash.dart';

void main() {
  runApp(const MyApp());
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
        colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: Colors.red,
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