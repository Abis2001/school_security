import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class CustomTypography extends StatelessWidget {
  String text;
  TextStyle style;
   CustomTypography({super.key,required this.text,required this.style});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style,
    );
  }
}