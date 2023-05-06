import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_security/utils/responsive.dart';
import 'package:school_security/utils/utils.dart';
import 'package:school_security/viewmodel/auth.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phoneNumber=TextEditingController();
  TextEditingController password=TextEditingController();
  @override
  Widget build(BuildContext context) {
    Responsive().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<Auth>(
        builder: (context, value, child) => 
         SafeArea
         (
          
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
                        CustomTypography(text: String.login.toUpperCase(), style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold
                        )),
                       
                      ],
                    ),
                     Container(
                      width: Responsive.width(0.8),
                       child: TextField(
                        controller: phoneNumber,
                        maxLength: 10,
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          labelText: 'Phone number',
                          hintText: 'Enter your phone number',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 2
                            )
                          )
                        ),
                       ),
                     ),
                     Container(
                      width: Responsive.width(0.8),
                       child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: password,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: 'Enter your password',
                          
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 2
                            )
                          )
                        ),
                       ),
                     ),
                     TextButton(
                          onPressed: ()async{
                           if(phoneNumber.text==null||password.text==null){
      
                           }else{
                             var provider=Provider.of<Auth>(context,listen: false);
                            await provider.login(phoneNumber: phoneNumber.text, password: password.text, context: context);
                            
                            if(provider.loginData.message.toString()=='No user found.'){
                              showDialog(context: context, builder: (context) => CupertinoAlertDialog(
                                content: Text('Invalid Credentials'),
                                actions: [
                                  TextButton(
                                    child: Text('OK'),
                                    onPressed: ()=>Navigator.of(context).pop(),
                                  )
                                ],
                              ));
                            }else if(provider.loginData.status==true||provider.loginData.status==false){
                              showDialog(context: context, builder: (context) => CupertinoAlertDialog(
                                content: Text('Logged Successfully'),
                                actions: [
                                  TextButton(
                                    child: Text('OK'),
                                    onPressed: ()=>Navigator.of(context).pushNamed(Routes.home),
                                  )
                                ],
                              ));
                            }else{
                              showDialog(context: context, builder: (context) => CupertinoAlertDialog(
                                content: Text('Try again later'),
                                actions: [
                                  TextButton(
                                    child: Text('OK'),
                                    onPressed: ()=>Navigator.of(context).pop(),
                                  )
                                ],
                              ));
                            }
                           }
      
                            //Navigator.pushNamed(context, Routes.home);
                          },
                          child:  (value.isLoading)?Container(height: 20,width: 20,child: CircularProgressIndicator(),):Text(ButtonText.login),
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
      ),
    );
  }
}