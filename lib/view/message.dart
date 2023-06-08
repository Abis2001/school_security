import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:school_security/utils/responsive.dart';
import 'package:school_security/utils/storage.dart';
import 'package:school_security/utils/utils.dart';
class Message extends StatefulWidget {
  const Message({super.key});

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  TextEditingController msgClr=TextEditingController();
  List messages=[
    'Hi',
    'Welcome !'
  ];
  var userRole;
  bool intializing=true;
  getCredentials()async{
    userRole=await SharedPrefUtils.getInt('role');
    setState(() {
      intializing=false;
    });
  }
  @override
  void initState() {
    getCredentials();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Responsive().init(context);
    return (intializing)?Center(child: const CircularProgressIndicator()):Container(
      height: Responsive.height(1),
      width: Responsive.width(1),
      child: Column(

        children: [
          Expanded(
            flex: 7,
            child: Container(
              padding: EdgeInsets.all(10),
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('users').doc('teachers').collection('messages').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No notifications found'));
          }
                  return ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(height: Responsive.height(0.02)),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) => Column(
                    children: [
                      Row(
                        mainAxisAlignment: (userRole==2)?MainAxisAlignment.start:MainAxisAlignment.end,
                        children: [
                          Container(
                            height: Responsive.height(0.03),
                            padding: EdgeInsets.symmetric(
                              horizontal: 30,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: (userRole==2)?BorderRadius.only(
                                bottomRight: Radius.circular(8),
                                topLeft:  Radius.circular(8),
                                topRight:  Radius.circular(8)
                              ):BorderRadius.only(
                                bottomLeft: Radius.circular(8),
                                topLeft:  Radius.circular(8),
                                topRight:  Radius.circular(8)
                              ),
                              color: Theme.of(context).colorScheme.primary
                            ),
                            child: CustomTypography(
                              text: snapshot.data!.docs[index]['messages'],
                              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                                color: Theme.of(context).colorScheme.background
                              ),
                            )
                          )
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: (userRole==2)?MainAxisAlignment.start:MainAxisAlignment.end,
                        children: [
                          CustomTypography(text: snapshot.data!.docs[index]['time'], style: Theme.of(context).textTheme.labelSmall!)
                        ],
                      )
                    ],
                  ),
                );
                },
              ),
          )),
          (userRole==2)?SizedBox.shrink():Expanded(
            flex: 1,
            child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: TextField(
            controller: msgClr,
            decoration: InputDecoration(
              hintText: 'Type a message...',
              border: InputBorder.none,
              suffixIcon: IconButton(
                onPressed: (){
                  if(msgClr.text.trim()!=''){
                  }
                  setState(() {
                    var now = DateTime.now().toLocal();
    var indianTime = now.toUtc().add(Duration(hours: 5, minutes: 30));
    var formattedTime = DateFormat('h:mm a').format(indianTime);
                    messages.add(msgClr.text);
                    FirebaseFirestore.instance.collection('users').doc('teachers').collection('messages').add({
                      'messages':msgClr.text,
                      'time':formattedTime
                    });
                    msgClr.clear();
                  });
                },
                icon: Icon(Icons.send),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            ),
          ),
        ),
          ),
        ],
      ),
    );
  }
}