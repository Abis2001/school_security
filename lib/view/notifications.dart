import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:school_security/utils/typography.dart';

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc('parents')
            .collection('students')
            .doc('notification')
            .collection('students')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No notifications found'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              var id=snapshot.data!.docs[index]['id'];
              var name=snapshot.data!.docs[index]['name'];
              var time=snapshot.data!.docs[index]['time'];
              bool status=snapshot.data!.docs[index]['status'];
                  snapshot.data!.docs.sort((a, b) => b['sortID'].compareTo((a['sortID'])));

              
              // Customize the UI according to your notification data
              return Container(
                margin: EdgeInsets.all(10),
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.2)
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: CircleAvatar(
                          radius: 40,
                          child: Icon(Icons.person),
                          backgroundColor: (status)?Colors.green:Colors.red,
                          foregroundColor: Theme.of(context).colorScheme.background,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTypography(
                              text: id,
                              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                                fontWeight: FontWeight.bold
                              ),
                            ),
                              SizedBox(
                                width: 200,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomTypography(
                                    text: name.toString().toUpperCase(),
                                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                                      fontWeight: FontWeight.bold
                                    ),
                                                          ),
                                                          CustomTypography(
                                    text: (status)?'IN':'OUT',
                                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: (status)?Colors.green:Colors.red
                                    ),
                                                          ),
                                                          
                                  ],
                                ),
                              ),
                              CustomTypography(
                                  text: time,
                                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                                    fontWeight: FontWeight.bold
                                  ),
                            ),
                            
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            }
          );
        },
      ),
    );
  }
}
