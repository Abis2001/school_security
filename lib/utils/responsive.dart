import 'package:flutter/material.dart';

class Responsive {
  static MediaQueryData? _mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;
  static double? defaultSize;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData?.size.width;
    screenHeight = _mediaQueryData?.size.height;
    defaultSize = screenWidth! > 400 ? screenWidth! * 0.025 : screenWidth! * 0.05;
  }

  static double height(double? height) {
    double screenHeight = _mediaQueryData?.size.height ?? 0;
    return (height ?? 0 / 812.0) * screenHeight;
  }

  static double width(double? width) {
    double screenWidth = _mediaQueryData?.size.width ?? 0;
    return (width ?? 0 / 375.0) * screenWidth;
  }

  static double textSize(double? textSize) {
    double screenWidth = _mediaQueryData?.size.width ?? 0;
    return (textSize ?? 0 / 375.0) * screenWidth;
  }
}
