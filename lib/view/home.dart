import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:school_security/utils/typography.dart';
import 'package:school_security/view/notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
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
    // 'Assignment',
    'Message',
    'Profile'
  ];
  List<Widget> tabs=[
        NotificationScreen(),
        // Container(),
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
int sortId=0;

String cardId='';
int? userId;
int? userRole;
String? username;
bool isLoading=true;
bool intializing=false;
getCredentials()async{
    userId=await SharedPrefUtils.getInt('userId');
    username=await SharedPrefUtils.getString('userame');
    userRole=await SharedPrefUtils.getInt('role');
  logDebug(username.toString());
  setState(() {
    isLoading=false;
  });
}
void update(id,value){
  setState(() {
    sortId++;
  });
var now = DateTime.now().toLocal();
    var indianTime = now.toUtc().add(Duration(hours: 5, minutes: 30));
    var formattedTime = DateFormat('h:mm a').format(indianTime);
    
    FirebaseFirestore.instance.collection('users').doc('parents').collection('students').doc('notification').collection('students').add(
      {
        'id':id,
        'sortID':sortId,
        'name':'${value['name']}',
        'status':value['status'],
        'time':formattedTime
      }
    );
}
void readData() {
 
  databaseReference.child('card').onValue .listen((event) async{
  docs.get().then((value) {
    final id=event.snapshot.child('id').value.toString();
    logDebug('id '+id);
    if(id==' 0B AC 8F 29'||id==' 2C 88 63 A2'){

  
     DocumentReference updatedocumentReference = FirebaseFirestore.instance.collection('users').doc('parents').collection('students').doc('$id');

    updatedocumentReference.get().then((value) async{
      if(value['status']==true){
         await updatedocumentReference.update(
      {
        'status':false
      }
     );
      final notification = await CustomNotification(
            title: ' ID DETECTED ',
            body: '${value['name']} In ${DateTime.now()} ',
    );
    
    await NotificationManager().showNotification(notification);
    update(id, value);
      }
      
      if(value['status']==false){
            var now = DateTime.now().toLocal();
    var indianTime = now.toUtc().add(Duration(hours: 5, minutes: 30));
    var formattedTime = DateFormat('h:mm a').format(indianTime);

       await  updatedocumentReference.update(
      {
        'status':true
      }
     );
      update(id, value);
         final notification =await CustomNotification(
            title: ' ID DETECTED ',
            body: '${event.snapshot.child('id').value.toString()} Out ${DateTime.now()} ',
    );
    
   await NotificationManager().showNotification(notification);
      }
    });
    
    
  }else{
     final notification =  CustomNotification(
            title: ' Unknown ID DETECTED ',
            body: ' unknown',
    );
    
     NotificationManager().showNotification(notification);
    }
      });
      
     


   
  });
 
  setState(() {
    intializing=true;
  });

}


  @override
  void initState() {
    readData();
    getCredentials();
    super.initState();
  }

  // @override
  // void didChangeDependencies() {
  //   readData();
  //   super.didChangeDependencies();
  // }
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
                        child: Center(
                          child: CustomTypography(
                            text: username.toString().substring(0,1).toUpperCase(),
                            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                              color: Theme.of(context).colorScheme.secondary
                            ),
                          ),
                        ),
                        radius: 40,
                        foregroundColor: Colors.red,
                        backgroundColor: Colors.white,
                      ),
                      
                    ],
                  ),
                  Row(
                    children: [
                      Text((username??'').toUpperCase(),
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
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.assignment),
            //               label: 'Assignment'
      
            // ),
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