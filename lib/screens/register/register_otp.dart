import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_booking/base/base_model.dart';
import 'package:food_booking/models/otp_countdown.dart';
import 'package:food_booking/models/user_model.dart';
import 'package:food_booking/screens/common/success_page.dart';
import 'package:food_booking/screens/home_page.dart';
import 'package:food_booking/screens/login/login_page.dart';
import 'package:food_booking/screens/register/register_page.dart';
import 'package:food_booking/shared/app_colors.dart';
import 'package:food_booking/shared/app_consts.dart';
import 'package:food_booking/shared/app_session.dart';
import 'package:food_booking/shared/widget/app_bar.dart';
import 'package:food_booking/shared/widget/loading.dart';
import 'package:food_booking/shared/widget/normal_button.dart';
import 'package:food_booking/shared/widget/otp_input.dart';
import 'package:food_booking/utils/common.dart';
import 'package:provider/provider.dart';

class RegisterOTPPage  extends StatelessWidget {

  final UserRegister userRegister;
  RegisterOTPPage({this.userRegister});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RegisterOTPModel>(
      create: (context) => RegisterOTPModel(),
      child: RegisterOTPWidget(userRegister: userRegister,),
    );
  }
}

class RegisterOTPWidget extends StatelessWidget {

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController controllerOTP = new TextEditingController();
  final UserRegister userRegister;
  RegisterOTPWidget({this.userRegister});

  @override
  Widget build(BuildContext context) {
    RegisterOTPModel pvdRegisterOTP= Provider.of<RegisterOTPModel>(context);
    Widget _buildButtonContinue() {
      return  Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
        child: SizedBox(
            width: double.infinity,
            height: 50,
            child: NormalButton(
              title: 'Tiếp tục',
              onPress: () {
                if(controllerOTP.text.length == 4){
                  registerAccount(context, pvdRegisterOTP);
                }else{

                }
              },
            )),
      );
    }
    Widget _buildAlert() {
      return Padding(
        padding:
        EdgeInsets.only(top: 32, bottom: 20),
        child: pvdRegisterOTP.counterOtp.message == ""
            ? RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text:
              "Tin nhắn đã được gửi đến số điện thoại của bạn.",
              style: TextStyle(
                  color: AppColors.colorTextFieldLabel),
            ))
            : RichText(
          textAlign: TextAlign.center,
          text: TextSpan(text: "",
              style: TextStyle(color: AppColors.colorTextHint),
              children: [
                pvdRegisterOTP.counterOtp.counter > 0 ?
                TextSpan(
                  text: "Gửi lại mã OTP (" + pvdRegisterOTP.counterOtp.counter.toString() + ")",
                  style: TextStyle(color: AppColors.colorLabel),
                )
                    : TextSpan(
                    text: "Gửi lại mã OTP",
                    style: TextStyle(color: AppColors.colorLabel, fontWeight:FontWeight.normal, fontSize: 15),
                    recognizer: new TapGestureRecognizer() ..onTap = () async {
                      pvdRegisterOTP.showLoading(true);
                      Future.delayed(Duration(seconds: 1), () async {

                      });
                    }
                )
              ]),
        ),
      );
    }
    return Stack(
      children: <Widget>[
        Scaffold(
            backgroundColor: Colors.white,
            key: _scaffoldKey,
            appBar: BookingAppBar.getAppBar(
                title: "NHẬP MÃ OTP"
            ),
            body: GestureDetector(
              onTapUp: (detail) {
                Common.hideSoftKeyboard(context);
              },
              child: Material(
                color: Colors.white,
                child: Center(
                  child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(30, 12, 30, 12),
                      constraints: BoxConstraints(minWidth: 100, maxWidth: 450),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(bottom: 48),
                            child: Center(
                              child: Text(
                                "Nhập mã OTP đã được gửi đến số điện thoại \n " + Common.replacePartString(userRegister.phone, "*"),
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 16, height: 1.5, fontWeight: FontWeight.w500, color: AppColors.colorTextFieldLabel),
                              ),
                            ),
                          ),
                          SharedOtpInput.otpInput(
                              controller: controllerOTP,
                              onTextChanged: (otp) {

                              },
                              onDone: (String code) {
                                if(code.length == 4){
                                  registerAccount(context, pvdRegisterOTP);
                                }
                              }
                          ),
                          _buildAlert(),
                          _buildButtonContinue(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
        ),
        LoadingView.widget(loading: pvdRegisterOTP.isShowLoading)
      ],
    );
  }

  void registerAccount(BuildContext context, RegisterOTPModel pvdRegisterOTP) async {
    pvdRegisterOTP.showLoading(true);
    Future.delayed(Duration(milliseconds: 500), () async {
      pvdRegisterOTP.showLoading(false);
      login(context, pvdRegisterOTP);
    });
  }
  void login(BuildContext context, RegisterOTPModel pvdRegisterOTP) async{
    Navigator.pushReplacement(context, CupertinoPageRoute(builder: (BuildContext context) => SuccessPage(logo: "icon_success.png",content: "Chúc mừng! Tài khoản của bạn đã được đăng ký thành công.",title: "ĐĂNG KÍ THÀNH CÔNG",titleButton: "Vào ứng dụng",
      onPress: (){
        UserProfile.setUser("0907152251");
        AppSession.instance.setSession(userName: "0907152251");
        Future.delayed(Duration(milliseconds: 500), () async {
          Navigator.pushReplacement(context, CupertinoPageRoute(builder: (BuildContext context) => HomePage()));
        });
      },)));
  }
}
class RegisterOTPModel extends BaseModel {
  RegisterOTPModel(){startCountDown();}
  var counterOtp = new OtpCountDown(counter: AppConstants.OTP_COUNT_DOWN_MAX, message: "none");
  Timer _timer;

  startCountDown() {
    if(_timer == null) {
      // Start countdown OTP message
      _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
        counterOtp = otpCountDown(counterOtp);
        if(counterOtp.counter <= 0) {
          timer.cancel();
        }
      });
    }
  }
  otpCountDown(OtpCountDown counter) {
    counterOtp.counter = counterOtp.counter - 1;
    super.update();
    return counter;
  }
  @override
  void dispose() {
    _timer.cancel();
    // TODO: implement dispose
    super.dispose();
  }
}