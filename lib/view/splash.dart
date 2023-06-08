import 'dart:async';

import 'package:flutter/material.dart';
import 'package:school_security/services/dio/logger/logger_interceptor.dart';
import 'package:school_security/utils/responsive.dart';
import 'package:school_security/utils/storage.dart';
import 'package:school_security/utils/utils.dart';
import 'package:school_security/view/home.dart';

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
    timer=Timer(Duration(seconds: 3), () async{
      var userId=await SharedPrefUtils.getInt('userId');
      logDebug('userID $userId');
      if(userId!=0||userId!=null){
        Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context)=> HomeScreen()),(route) => false);
      }else{
        Navigator.pushNamed(context, Routes.login);
      }
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