import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:school_security/constants/routes.dart';
import 'package:school_security/services/dio/logger/logger_interceptor.dart';
import 'package:school_security/utils/responsive.dart';
import 'package:school_security/view/appointment.dart';
import 'package:school_security/view/messages.dart';
import 'package:school_security/view/notification.dart';
import 'package:school_security/view/profile.dart';

import '../services/notifications/notification.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex=0;
  List<String> titles=[
    'Notifications',
    'Assignment',
    'Holidays',
    'Message',
    'Profile'
  ];
  List<Widget> tabs=[
    NotificationScreen(),
        Container(),
        Container(), 
        MessageScreen(), 
        ProfileScreen(), 

  ];
final databaseReference = FirebaseDatabase.instance.reference();
FirebaseFirestore firestore = FirebaseFirestore.instance;
final docs=FirebaseFirestore.instance.collection('users').doc('students');    
List<String> ids=[
  '0B AC 8F 29'// Bala,
  '2C 88 63 A2'
];
String keyId='';
String cardId='';
void readData() {
 
  databaseReference.child('card').onValue.listen((event) async{
  docs.get().then((value) {
    final id=event.snapshot.child('id').value.toString();
    final Username=value.get(id)['username'];
    logDebug(id+Username);
     final notification = CustomNotification(
            title: 'Id Detected',
            body: '$Username $id ',
    );
    NotificationManager().showNotification(notification);
    // DocumentReference updatedocumentReference = FirebaseFirestore.instance.collection('users').doc('students').collection('notifications').doc(' 2C 88 63 A2');

    // updatedocumentReference.update({
    //         'status': false,
    //       });
      });

     
  });

}


  @override
  void initState() {
    readData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(titles.elementAt(currentIndex)),
      ),
      drawer: Drawer(
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: Responsive.height(0.25),
              color: Theme.of(context).colorScheme.primary,
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.white,
                      ),
                      
                    ],
                  ),
                  Row(
                    children: [
                      Text('Abishek',
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        letterSpacing: 2.0,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.background
                      ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Container(
              height: Responsive.height(0.3),
              padding: EdgeInsets.symmetric(horizontal: Responsive.width(0.02)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Icon(Icons.class_),
                      SizedBox(width: Responsive.width(0.04)),
                      Text('class'),
                    ],
                  ),
                   Row(
                    children: [
                      Icon(Icons.person),
                      SizedBox(width: Responsive.width(0.04)),
                      Text('student profile'),
                    ],
                  ),
                   InkWell(
                    onTap: (){
                      readData();
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Appoointment()));
                    },
                     child: Row(
                      children: [
                        Icon(Icons.calendar_month),
                        SizedBox(width: Responsive.width(0.04)),
                        Text('Appointment'),
                      ],
                                     ),
                   ),
                   Row(
                    children: [
                      Icon(Icons.leave_bags_at_home),
                      SizedBox(width: Responsive.width(0.04)),
                      Text('leave'),
                    ],
                  ),
                   InkWell(
                    onTap: (){
                      Navigator.pushNamed(context, Routes.login);
                    },
                     child: Row(
                      children: [
                        Icon(Icons.logout),
                        SizedBox(width: Responsive.width(0.04)), 
                        Text('logout'),
                      ],
                                     ),
                   )
                ],
              ),
            ),
            Container(
              height: Responsive.height(0.4),
              
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Ver 1.0.0')
                    ],
                  ),
                  SizedBox(
                    height: Responsive.height(0.02),
                  )
                ],
              ),
            )
          ],
        ),    
      ),
      body: tabs.elementAt(currentIndex),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20)
          ),
          color: Colors.red
        ),
        height: 80,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          elevation: 10,
          unselectedItemColor: Colors.black,
          showUnselectedLabels: true,
          selectedFontSize: 12,
          unselectedFontSize: 10,
          backgroundColor: Colors.transparent,
          currentIndex: currentIndex,
          iconSize: 25,
          selectedItemColor: Theme.of(context).colorScheme.background,
          onTap: (value) {
            setState(() {
              currentIndex=value;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: 'Notifications'
              
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.assignment),
                          label: 'Assignment'
      
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.run_circle_outlined),
                          label: 'Holidays'
      
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.message),
                          label: 'message'
      
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
                          label: 'Profile'
      
            )
          ],
        ),
      ),
    );
  }
}