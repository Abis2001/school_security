import 'dart:async';

import 'package:flutter/material.dart';
import 'package:school_security/utils/responsive.dart';
import 'package:school_security/utils/utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timer=Timer(Duration(seconds: 3), () {
      Navigator.pushNamed(context, Routes.login);
     });
  }
  @override
  Widget build(BuildContext context) {
    Responsive().init(context);
    return Scaffold(
      body: Container(
        height: Responsive.screenHeight,
        width: Responsive.screenWidth,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}