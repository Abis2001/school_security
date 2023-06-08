import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:school_security/constants/routes.dart';
import 'package:school_security/services/dio/logger/logger_interceptor.dart';
import 'package:school_security/utils/responsive.dart';
import 'package:school_security/utils/storage.dart';
import 'package:school_security/view/message.dart';
import 'package:school_security/view/tabs/profile.dart';

import '../services/notifications/notification.dart';
import 'login.dart';
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
    'Message',
    'Profile'
  ];
  List<Widget> tabs=[
        Container(),
        Container(),
        Message(), 
        Profile(), 

  ];
final databaseReference = FirebaseDatabase.instance.reference();

FirebaseFirestore firestore = FirebaseFirestore.instance;
final docs=FirebaseFirestore.instance.collection('users').doc('students');    
bool isTimeInRange(TimeOfDay currentTime, TimeOfDay startTime, TimeOfDay endTime) {
  if (currentTime.hour > startTime.hour && currentTime.hour < endTime.hour) {
    return true;
  } else if (currentTime.hour == startTime.hour && currentTime.minute >= startTime.minute) {
    return true;
  } else if (currentTime.hour == endTime.hour && currentTime.minute <= endTime.minute) {
    return true;
  } else {
    return false;
  }
}
List<String> ids=[
  '0B AC 8F 29'// Bala,
  '2C 88 63 A2'
];
String keyId='';
String cardId='';
int? userId;
int? userRole;
String? username;
bool isLoading=true;
getCredentials()async{
  userId=await SharedPrefUtils.getInt('userId');
  userRole=await SharedPrefUtils.getInt('role');
  username=await SharedPrefUtils.getString('username');
  logDebug(username.toString());
  setState(() {
    isLoading=false;
  });
}
void readData() {
 
  databaseReference.child('card').onValue.listen((event) async{
   
  docs.get().then((value) {
    // if(value.get(event.snapshot.child('id').value.toString())['status']==true){
    //  docs.update({
    //       event.snapshot.child('id').value.toString():{
    //         'In':true,
    //         'status':true,
    //       }
    //       });
    // }
    final id=event.snapshot.child('id').value.toString();
    final Username=value.get(id)['username'];
    final status=value.get(id)['status'];
    logDebug(status.toString());
     final notification = CustomNotification(
            title: 'Id Detected',
            body: '$Username $id ',
    );
    
    NotificationManager().showNotification(notification);
   
    // DocumentReference updatedocumentReference = FirebaseFirestore.instance.collection('users').doc('students').collection('notifications').doc(' 2C 88 63 A2');

    // out
    DateTime now = DateTime.now();
  TimeOfDay currentTime = TimeOfDay.fromDateTime(now);

  TimeOfDay morningStartTime = TimeOfDay(hour: 9, minute: 30);
  TimeOfDay morningEndTime = TimeOfDay(hour: 9, minute: 45);
  TimeOfDay eveningStartTime=TimeOfDay(hour: 16, minute: 10);
  TimeOfDay eveningEndTime=TimeOfDay(hour: 16, minute: 30);
  
  if(!isTimeInRange(currentTime, morningStartTime, morningEndTime)){
     docs.update({
          event.snapshot.child('id').value.toString():{
            'status':true,
            'absent':false
          }
          });
    logDebug('Student In');
  }else{
    // time end
      logDebug('out');
       docs.update({
          event.snapshot.child('id').value.toString():{
            'status':false,
            'absent':true,
          }
          });
    
    
  }
  if(!isTimeInRange(currentTime, eveningStartTime, eveningEndTime)){
    logDebug('In');
     docs.update({
          event.snapshot.child('id').value.toString():{
            'status':true,
            'absent':false
          }
          });
  }else{
    // time end
      logDebug('absent');
       docs.update({
          event.snapshot.child('id').value.toString():{
            'status':false,
            'absent':true,
          }
          });
    
    
  }
      });
     


     
  });

}


  @override
  void initState() {
    //readData();
    getCredentials();
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
                      Text(username??'',
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
                       Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> LoginScreen()), (route) => false);
                    SharedPrefUtils.clearData();
                 
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
          color: Theme.of(context).colorScheme.primary
        ),
        height: 80,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          elevation: 10,
          unselectedItemColor: Colors.white,
          showUnselectedLabels: true,
          selectedFontSize: 12,
          unselectedFontSize: 10,
          backgroundColor: Colors.transparent,
          currentIndex: currentIndex,
          iconSize: 25,
          selectedItemColor: Theme.of(context).colorScheme.secondary,
          onTap: (value) {
            setState(() {
              currentIndex=value;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: 'Notifications'
              
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.assignment),
                          label: 'Assignment'
      
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.message),
                          label: 'Message'
      
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