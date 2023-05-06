import 'package:flutter/material.dart';
import 'package:school_security/utils/responsive.dart';

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
  @override
  Widget build(BuildContext context) {
    Responsive().init(context);
    return Scaffold(
     body: SafeArea(
        child: Container(
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
                      CustomTypography(text: String.register.toUpperCase(), style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold
                      )),
                     
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(width: Responsive.width(0.04),),
                      DropdownButton(
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
                          print(dropDownValue);
                        });
                      },
                      ),
                    ],
                  ),
                    Container(
                    width: Responsive.width(0.8),
                     child: TextField(
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
                      textInputAction: TextInputAction.next,
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
                   Container(
                    width: Responsive.width(0.8),
                     child: TextField(
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        labelText: 'Confirm password',
                        hintText: 'Enter your confirm password',
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
                        child: const Text(ButtonText.login),
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