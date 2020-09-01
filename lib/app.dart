import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_booking/screens/app_controller.dart';
import 'package:food_booking/screens/splash_screen.dart';
import 'package:food_booking/shared/widget/booking_material_app.dart';
import 'package:food_booking/utils/common.dart';
import 'package:get/route_manager.dart';
import 'package:get/get.dart';


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MyMainApp();
  }
}
class MyMainApp extends StatefulWidget {

  @override
  MyMainAppState createState() => new MyMainAppState();
}

class MyMainAppState extends State<MyMainApp> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (detail) {
        Common.hideSoftKeyboard(context);
      },
      child: BookingMaterialApp.getMaterialApp(
          home: SplashScreen()
      ),
    );
  }
}
