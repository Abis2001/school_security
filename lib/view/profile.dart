import 'package:flutter/material.dart';
import 'package:school_security/utils/responsive.dart';
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Responsive().init(context);
    return Container(
      height: Responsive.screenHeight,
      width: Responsive.screenWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 100,
                width: 100,
                child: Center(
                  child: Text('A',
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    color: Theme.of(context).colorScheme.background
                  ),
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Theme.of(context).colorScheme.primary
                ),
              )
            ],
          ),
          Column(
            children: [
              Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('LimatTech',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold
              ),
              )
            ],
          ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Limatech Higher secondary school, coimbatore')
                ],
              ),
              Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('X standard B section')
            ],
          ),
            ],
          ),
           Divider(),
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
               
                Row(
          
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("ROLL No :"),
                    Text("xxxxxxxxxx")
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("RFID NUMBER :"),
                    Text("xxxxxxxxxx")
                  ],
                ),
              ],
            ),
          ),
          
          Divider(),
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  children: [
                    Text('Personal Details')
                  ],
                ),
                Row(
          
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Father's Name :"),
                    Text("xxxxxxxxxx")
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Mother's Name :"),
                    Text("xxxxxxxxxx")
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Date of Birth :"),
                    Text("xxxxxxxxxx")
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Blood Group :"),
                    Text("xxxxxxxxxx")
                  ],
                )
              ],
            ),
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  children: [
                    Text('Contact Details')
                  ],
                ),
                Row(
          
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Mobile Number :"),
                    Text("xxxxxxxxxx")
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Email Id :"),
                    Text("xxxxxxxxxx")
                  ],
                ),
               
              ],
            ),
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(onPressed: (){

                  }, icon: Icon(Icons.logout,color: Theme.of(context).colorScheme.primary,))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('LOGOUT')
                ],
              ),

            ],
          )
          
        ],
      ),
    );
  }
}