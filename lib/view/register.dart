import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:school_security/services/dio/logger/logger_interceptor.dart';
import 'package:school_security/utils/responsive.dart';
import 'package:school_security/viewmodel/auth.dart';

import '../utils/utils.dart';
 const List items=[
    'Parents / Students',
    'Teachers',
    'Admin'
  ];
class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var dropDownValue=items.first;
  int role=2;
  TextEditingController usernameClr=TextEditingController();
  TextEditingController passwordClr=TextEditingController();
  TextEditingController phoneClr=TextEditingController();
  TextEditingController emailClr=TextEditingController();
  @override
  Widget build(BuildContext context) {
    FocusNode focusNode=FocusNode();
    Responsive().init(context);
    return Scaffold(
      backgroundColor: Colors.blueAccent, 
     body: SafeArea(
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
                      CustomTypography(text: 'Create new account'.toUpperCase(),
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
                height: Responsive.height(0.7),
                width: Responsive.screenWidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)
                  ),
                  color: Theme.of(context).colorScheme.background
                ),
                child: SingleChildScrollView(
                  child: Container(
                    height: Responsive.height(0.7),
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                       
                        Row(
                          children: [
                            SizedBox(width: Responsive.width(0.04),),
                            DropdownButtonHideUnderline(
                              child: DropdownButton(
                                value: dropDownValue,
                                
                                items: items.map(( value) {
                                return DropdownMenuItem(
                                  
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                                onChanged: ( value) {
                                // This is called when the user selects an item.
                                setState(() {
                            
                                  dropDownValue = value!;
                                  if(dropDownValue=='Parents / Students'){
                                    role=2;
                                  }else if(dropDownValue=='Admin'){
                                    role=1;
                                  }else{
                                    role=3;
                                  }
                                  print(dropDownValue);
                                });
                              },
                              ),
                            ),
                          ],
                        ),
                          Container(
                          width: Responsive.width(0.8),
                           child: TextFormField(
                            controller: usernameClr,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              labelText: 'Username',
                              hintText: 'Enter your username',
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
                           child: TextFormField(
                            controller: phoneClr,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            keyboardType: TextInputType.phone,
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
                           child: TextFormField(
                            controller: emailClr,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              hintText: 'Enter your email',
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
                           child: TextFormField(
                            controller: passwordClr,
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
                        
                         ElevatedButton(
                              onPressed: ()async{
                                var provider=Provider.of<Auth>(context,listen: false);
                                await provider.register(userName: usernameClr.text, phoneNumber: phoneClr.text, password: passwordClr.text, email: emailClr.text, role: role, context: context).then((value) {
                                 if(provider.registerData.message=='A user with that email already exists.'){
                                  showDialog(context: context, builder: (context) => CupertinoAlertDialog(
                                      content: Text(provider.registerData.message!),
                                      actions: [
                                        TextButton(
                                          child: const Text('OK'),
                                          onPressed: ()=>Navigator.of(context).pop(),
                                        )
                                      ],
                                    ));
                                 }else if(provider.registerData.message=='User created successfully.'){
                                  showDialog(context: context, builder: (context) => CupertinoAlertDialog(
                                      content: Text('your account has been created successfully'),
                                      actions: [
                                        TextButton(
                                          child: Text('OK'),
                                          onPressed: ()=>Navigator.of(context).pop(),
                                        )
                                      ],
                                    ));
                                 }else{
                                  showDialog(context: context, builder: (context) => CupertinoAlertDialog(
                                      content: Text('Please try again later'),
                                      actions: [
                                        TextButton(
                                          child: Text('OK'),
                                          onPressed: ()=>Navigator.of(context).pop(),
                                        )
                                      ],
                                    ));
                                 }
                                });
                              },
                              child: const Text(ButtonText.register),
                            ),
                         Row(
                          children: [
                            CustomTypography(text: String.aAc, style: Theme.of(context).textTheme.bodyMedium!),
                            TextButton(
                              onPressed: (){
                                Navigator.pushNamed(context, Routes.login);
                              },
                              child: const Text(ButtonText.signin),
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
    );
  }
}