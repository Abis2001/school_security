import 'package:flutter/material.dart';
import 'package:school_security/utils/responsive.dart';
class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Responsive().init(context);
    return Container(
      height: Responsive.screenHeight,
      child: ListView.separated(
        separatorBuilder: (context, index) => SizedBox(height: 10),
        itemCount: 15,
        itemBuilder: (context, index) => 
        Padding(
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
                            Text('Student Name : xxxxx '),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('RFID Number : xxxxx '),
                          ],
                        ),
                        
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text((index.isOdd)?'In : 9:00 AM':'Out : 4:30 PM'),
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
        )
      ),
    );
  }
}