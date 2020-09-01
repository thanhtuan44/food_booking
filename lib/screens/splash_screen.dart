import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_booking/data/spref.dart';
import 'package:food_booking/models/user_model.dart';
import 'package:food_booking/screens/home_page.dart';
import 'package:food_booking/screens/login/login_page.dart';
import 'package:food_booking/shared/app_colors.dart';
import 'package:food_booking/shared/app_consts.dart';
import 'package:food_booking/shared/app_session.dart';
import 'package:food_booking/utils/assets_link.dart';
import 'package:food_booking/utils/common.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    _startApp();
  }

  _startApp() {
    // LOAD USER PROFILE
    Future.delayed(
      Duration(seconds: 1), () async {
        String userName = await UserProfile.getUser();
        if (userName == null) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) =>
                  LoginPage()), (Route<dynamic> route) => false);
        } else {
          AppSession.instance.setSession(userName: userName);
          Navigator.pushReplacement(context, CupertinoPageRoute(builder: (BuildContext context) => HomePage()));
        }
      }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(child: Container(),),
                new Image.asset(assetsLink + 'logo_splash.png', width: 120,),
                Container(height: 32,),
                Expanded(child: Container(),),
                Container(
                  child: Center(
                    child: Loading(indicator: BallPulseIndicator(), size: 36.0,color: AppColors.colorLogoBookingAccent),
                  ),
                ),
                Container(height: 36,),
              ],
            )
        ),
      ),
    );
  }
}