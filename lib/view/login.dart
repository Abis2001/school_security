import 'dart:io';

import 'package:flutter/material.dart';
import 'package:school_security/utils/responsive.dart';
import 'package:school_security/utils/utils.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    Responsive().init(context);
    return Scaffold(
      body: SafeArea(
        
        child: Container(
          margin: EdgeInsets.all(Responsive.height(0.01)),
          height: Responsive.screenHeight,
          width: Responsive.screenWidth,
          child: SingleChildScrollView(
            child: Container(
          height: Responsive.screenHeight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      CustomTypography(text: String.login.toUpperCase(), style: Theme.of(context).textTheme.headlineSmall!),
                     
                    ],
                  ),
                   Container(
                    width: Responsive.width(0.8),
                     child: TextField(
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: 'Phone number',
                        hintText: 'Enter your phone number',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.red,
                            width: 2
                          )
                        )
                      ),
                     ),
                   ),
                   Container(
                    width: Responsive.width(0.8),
                     child: TextField(
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Enter your password',
                        
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.red,
                            width: 2
                          )
                        )
                      ),
                     ),
                   ),
                   TextButton(
                        onPressed: (){
                          Navigator.pushNamed(context, Routes.home);
                        },
                        child: const Text(ButtonText.login),
                      ),
                   Row(
                    children: [
                      CustomTypography(text: String.dAc, style: Theme.of(context).textTheme.bodyMedium!),
                      TextButton(
                        onPressed: (){
                          Navigator.pushNamed(context, Routes.register);
                        },
                        child: const Text(ButtonText.register),
                      ),
                    ],
                   )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}