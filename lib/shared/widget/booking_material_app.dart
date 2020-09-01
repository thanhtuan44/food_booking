import 'package:flutter/material.dart';

class BookingMaterialApp
{
  static Widget getMaterialApp({@required Widget home})
  {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'SF-Pro-Rounded'),
      home: home,
    );
  }
}