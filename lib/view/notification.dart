import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:school_security/utils/responsive.dart';
class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  Stream<QuerySnapshot> stream = FirebaseFirestore.instance.collection('users').doc('students').collection('notifications').snapshots();
  @override
  Widget build(BuildContext context) {
    Responsive().init(context);
    return Container(
      height: Responsive.screenHeight,
      child: StreamBuilder<QuerySnapshot>(
        stream: stream,
        builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
          List<QueryDocumentSnapshot> documents = snapshot.data!.docs;
            if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
          return ListView.separated(
          separatorBuilder: (context, index) => SizedBox(height: 10),
          itemCount: documents.length,
          itemBuilder: (context, index) {
            String documentId = documents[index].id;
            Object? data = documents.elementAt(index).data();
            return Padding(
            padding: EdgeInsets.all(10),
            child: Material(
              borderRadius: BorderRadius.circular(Responsive.height(0.01)),
              elevation: 10,
              shadowColor: Theme.of(context).colorScheme.primary,
              child: Container(
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      child: Center(
                        child: Icon((index.isOdd)?Icons.person_off_outlined:Icons.person,color: Theme.of(context).colorScheme.background,),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color:(index.isOdd)? Colors.red:Colors.green
                      ),
                    ),
                    Container(
                      width: 250,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              (index.isEven||index==2)?SizedBox.shrink():Icon(Icons.dangerous_sharp,color: Colors.amber,),
                              Text((index.isEven)?(index==2)?"Leaves school safely":'Reached school Safely':"Student failed to reach "),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('Student Name : ${documents.elementAt(index)['username']} '),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('RFID Number : ${documents.elementAt(index)['cardId']}  '),
                            ],
                          ),
                          
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(' ${(documents.elementAt(index)['status']==true)?'In':'Out'} ${documents.elementAt(index)['time']}'),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Responsive.height(0.01)),
                  color: Theme.of(context).colorScheme.background
                ),
              ),
            ),
          );
          }
        );
        },
      ),
    );
  }
}