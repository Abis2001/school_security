import 'package:flutter/material.dart';
import 'package:school_security/constants/routes.dart';
import 'package:school_security/utils/responsive.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: Responsive.height(0.2),
              color: Theme.of(context).colorScheme.primary,
            ),
            Container(
              height: Responsive.height(0.4),
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
                   Row(
                    children: [
                      Icon(Icons.calendar_month),
                      SizedBox(width: Responsive.width(0.04)),
                      Text('Appointment'),
                    ],
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
      body: Container(),
    );
  }
}