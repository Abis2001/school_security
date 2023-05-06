import 'package:flutter/material.dart';
import 'package:school_security/utils/responsive.dart';
class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  @override
  Widget build(BuildContext context) {
    Responsive().init(context);
    return Scaffold(
      
      body: Container(
        height: Responsive.screenHeight,
        child: ListView.separated(
          itemCount: 2, 
          separatorBuilder: (context, index) => SizedBox(height: 10,),
          itemBuilder: (context, index) => Padding(
            padding: EdgeInsets.all(10), 
            child: Material(
              elevation: 10,
              shadowColor: Colors.red,
              borderRadius: BorderRadius.circular(10),
              child: Container( 
                height: 50,
                width: Responsive.screenWidth,
                color: Colors.white,
                child: Center(child: Text((index.isEven)?'Tommorow is holiday - 07-05-2023':'Parents meetings towards 10-05-2023')),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(backgroundColor: Colors.red, child: Icon(Icons.add,color: Colors.white,),onPressed: (){},),
    );
  }
}