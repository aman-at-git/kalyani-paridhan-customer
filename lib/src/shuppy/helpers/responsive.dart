import 'package:flutter/material.dart';

class Responsive{
  static double width(double p,BuildContext context)
  {
    double? w = MediaQuery.of(context).size.width*(p/100);
    return w;
  }
  static double height(double p,BuildContext context)
  {
    return MediaQuery.of(context).size.height*(p/100);
  }
}