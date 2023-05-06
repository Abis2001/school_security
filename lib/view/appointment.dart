import 'package:flutter/material.dart';
import 'package:school_security/view/calender.dart';
class Appoointment extends StatefulWidget {
  const Appoointment({super.key});

  @override
  State<Appoointment> createState() => _AppoointmentState();
}

class _AppoointmentState extends State<Appoointment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Calendar(
      
      ),
    );
  }
}