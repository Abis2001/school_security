import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:school_security/utils/responsive.dart';
import 'package:school_security/utils/storage.dart';
import 'package:school_security/utils/utils.dart';
class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int? userId;
  var username;
  int? userRole;
  bool isLoading=true;
  getCredentials()async{
    userId=await SharedPrefUtils.getInt('userId');
    username=await SharedPrefUtils.getString('userame');
    userRole=await SharedPrefUtils.getInt('role');
    setState(() {
      isLoading=false;
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
    return Container(
      height: Responsive.height(1),
      width: Responsive.width(1),
      child: (isLoading)?Center(child: CircularProgressIndicator(),):SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            CircleAvatar(
              radius: 60,
              child: CustomTypography(text: username.toString().substring(0,1).toUpperCase(), style: Theme.of(context).textTheme.displayMedium!.copyWith(
                color: Theme.of(context).colorScheme.background
              )),
              //backgroundImage: AssetImage('assets/profile_image.jpg'),
            ),
            SizedBox(height: 10),
            Text(
              username.toString().toUpperCase(),
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              (userRole==1)?'Admin':(userRole==2)?'Teacher':'Student',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 50),
            Container(
              height: Responsive.height(0.05),
              width: Responsive.width(0.6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Theme.of(context).colorScheme.primary.withOpacity(0.2)
              ),
              child: Center(
                child: CustomTypography(
                  text: 'privacy policy',
                  style: Theme.of(context).textTheme.labelMedium!,
                ),
              ),
            ),
            const SizedBox(height: 50),
            Container(
              height: Responsive.height(0.05),
              width: Responsive.width(0.6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Theme.of(context).colorScheme.primary.withOpacity(0.2)
              ),
              child: Center(
                child: CustomTypography(
                  text: 'support',
                  style: Theme.of(context).textTheme.labelMedium!,
                ),
              ),
            ),
             const SizedBox(height: 50),
            Container(
              height: Responsive.height(0.05),
              width: Responsive.width(0.6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Theme.of(context).colorScheme.primary.withOpacity(0.2)
              ),
               child: Center(
                child: CustomTypography(
                  text: 'Logout',
                  style: Theme.of(context).textTheme.labelMedium!,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}