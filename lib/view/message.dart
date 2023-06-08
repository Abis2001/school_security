import 'package:flutter/material.dart';
import 'package:school_security/utils/responsive.dart';
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
  @override
  Widget build(BuildContext context) {
    Responsive().init(context);
    return Container(
      height: Responsive.height(1),
      width: Responsive.width(1),
      child: Column(

        children: [
          Expanded(
            flex: 7,
            child: Container(
              padding: EdgeInsets.all(10),
              child: ListView.separated(
                separatorBuilder: (context, index) => SizedBox(height: Responsive.height(0.02)),
                itemCount: messages.length,
                itemBuilder: (context, index) => Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: Responsive.height(0.03),
                      padding: EdgeInsets.symmetric(
                        horizontal: 30,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(8),
                          topLeft:  Radius.circular(8),
                          topRight:  Radius.circular(8)
                        ),
                        color: Theme.of(context).colorScheme.primary
                      ),
                      child: CustomTypography(
                        text: messages.elementAt(index),
                        style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          color: Theme.of(context).colorScheme.background
                        ),
                      )
                    )
                  ],
                ),
              ),
          )),
          Expanded(
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
                    messages.add(msgClr.text);
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