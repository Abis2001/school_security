import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  bool ObscureText=true;
    Phonevalidator() {
    if ((phoneNumber.text.isEmpty || phoneNumber.text == '')) {
      return 'Please enter phone number';
    } 
    }
    PassValidator(){
      if ((password.text.isEmpty && password.text == '')) {
      return 'Please enter password';
    } 
    }
  @override
  Widget build(BuildContext context) {
    Responsive().init(context);
    return Scaffold(
      backgroundColor: Colors.blueAccent, 
      body: Consumer<Auth>(
        builder: (context, value, child) => 
         SafeArea
         (
          
          child: Stack(
            children: 
              [
                Positioned(
                  top: 0,
                  child: Container(
                   height: Responsive.height(0.26),
                  width: Responsive.screenWidth,
                  color: Colors.transparent, 
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomTypography(text: 'Welcome Back!'.toUpperCase(),
                      style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                    color: Theme.of(context).colorScheme.background,
                                    fontWeight: FontWeight.bold
                                  )),
                    ],
                  ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                   padding: EdgeInsets.all(Responsive.height(0.012)),
                  height: Responsive.height(0.7),
                  width: Responsive.screenWidth,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)
                    ),
                                      color: Colors.white,
                  ),
                  child: SingleChildScrollView(
                    child: Container(
                  height: Responsive.height(0.7),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // Row(
                          //   children: [
                          //     CustomTypography(text: String.login.toUpperCase(), style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          //       color: Theme.of(context).colorScheme.primary,
                          //       fontWeight: FontWeight.bold
                          //     )),
                             
                          //   ],
                          // ),
                           Container(
                            width: Responsive.width(0.8),
                            height: Responsive.height(0.1),
                             child: TextFormField(
                              controller: phoneNumber,
                              maxLength: 10,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              keyboardType: TextInputType.phone,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                labelText: 'Phone number',
                                hintText: 'Enter your phone number',
                                errorText: Phonevalidator(),
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
                            height: Responsive.height(0.1),
                             child: TextFormField(
                              keyboardType: TextInputType.text,
                              controller: password,
                              
                              textInputAction: TextInputAction.done,
                              obscureText: ObscureText,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                hintText: 'Enter your password',
                                errorText: PassValidator(),
                                suffixIcon: IconButton(
                                  icon: Icon((ObscureText)?Icons.remove_red_eye_outlined:Icons.remove_red_eye),
                                  onPressed: (){
                                    setState(() {
                                      ObscureText=!ObscureText;
                                    });
                                  },
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 2
                                  )
                                )
                              ),
                             ),
                           ),
                           ElevatedButton(
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
                                child:  (value.isLoading)?Container(height: 20,width: 20,child: CircularProgressIndicator(),):Text(ButtonText.signin.toUpperCase(),
                                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.background
                                ),
                                ),
                              ),
                           Row(
                            children: [
                              CustomTypography(text: String.dAc, style: Theme.of(context).textTheme.bodyMedium!),
                              TextButton(
                                onPressed: (){
                                  Navigator.pushNamed(context, Routes.register);
                                },
                                child:  Text(ButtonText.register.toUpperCase()),
                              ),
                            ],
                           )
                        ],
                      ),
                    ),
                  ),
                              ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}