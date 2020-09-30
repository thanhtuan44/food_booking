import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:food_booking/models/otp_countdown.dart';
import 'package:food_booking/screens/forgot/forgot_password.dart';
import 'package:food_booking/screens/forgot/forgot_password_reset.dart';
import 'package:food_booking/shared/app_colors.dart';
import 'package:food_booking/shared/app_consts.dart';
import 'package:food_booking/shared/widget/app_bar.dart';
import 'package:food_booking/shared/widget/loading.dart';
import 'package:food_booking/shared/widget/normal_button.dart';
import 'package:food_booking/shared/widget/otp_input.dart';
import 'package:food_booking/utils/common.dart';



class ForgotPassOTPPage extends StatefulWidget {
  ForgotPassModel model;
  ForgotPassOTPPage({this.model});
  @override
  ForgotPassOTPPageState createState() => ForgotPassOTPPageState();
}
class ForgotPassOTPPageState extends State<ForgotPassOTPPage> {

  TextEditingController controllerPinCode = new TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool showLoading = false;
  Timer _timer;
  var counterOtp = new OtpCountDown(counter: AppConstants.OTP_COUNT_DOWN_MAX, message: "none");
  @override
  void initState() {
    startCountDown();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
            backgroundColor: Colors.white,
            key: _scaffoldKey,
            appBar: BookingAppBar.getAppBar(
                title: "NHẬP MÃ OTP",
                showBackButton: false
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
                                "Nhập mã OTP đã được gửi đến số điện thoại \n " + Common.replacePartString(widget.model.phoneEmail, "*"),
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 16, height: 1.5, fontWeight: FontWeight.w500, color: AppColors.colorTextFieldLabel),
                              ),
                            ),
                          ),
                          SharedOtpInput.otpInput(
                              controller: controllerPinCode,
                              onDone: (String code) {
                                // Check validate OTP
                                _validateOTP();
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
        LoadingView.widget(loading: showLoading),
      ],
    );
  }
  final FocusNode phoneFocus = FocusNode();

  Widget _buildButtonContinue() {
    return  Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: SizedBox(
          width: double.infinity,
          height: 50,
          child: NormalButton(
            title: 'Tiếp tục',
            onPress: () {
              _validateOTP();
            },
          )),
    );
  }
  _validateOTP() async
  {
    widget.model.otpCode = controllerPinCode.text.trim();
    if(widget.model.otpCode.length != 4) {
      Common.showSnackBarWithKey(scaffoldKey: _scaffoldKey, message: "Mã OTP không hợp lệ, vui lòng thử lại.", background: AppColors.colorSnackBarError);
    } else {
      setState(() {
        showLoading = true;
      });
      Future.delayed(Duration(milliseconds: 500), () async {
        setState(() {
          showLoading = false;

        });
        Navigator.pushReplacement(context, CupertinoPageRoute(builder: (BuildContext context) => ForgotPassResetPage(model: this.widget.model,)));

      });
    }
  }


  Widget _buildAlert() {
    return Padding(
      padding:
      EdgeInsets.only(top: 32, bottom: 20),
      child: counterOtp.message == ""
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
              counterOtp.counter > 0 ?
              TextSpan(
                text: "Gửi lại mã OTP (" + counterOtp.counter.toString() + ")",
                style: TextStyle(color: AppColors.colorLabel),
              )
                  : TextSpan(
                  text: "Gửi lại mã OTP",
                  style: TextStyle(color: AppColors.colorLabel, fontWeight:FontWeight.normal, fontSize: 15),
                  recognizer: new TapGestureRecognizer() ..onTap = () async {
                    setState(() {
                      showLoading = true;
                    });
                    Future.delayed(Duration(milliseconds: 500), () async {
                      setState(() {
                        showLoading = false;
                      });
                    });

                    if (widget.model.otpToken != null && widget.model.otpToken != '') {
                      setState(() {
                        counterOtp.message = "";
                      });
                    }
                  }
              )
            ]),
      ),
    );
  }
  otpCountDown(OtpCountDown counter) {
    counter.counter = counter.counter - 1;
    return counter;
  }
  startCountDown() {
    if(_timer == null) {
      // Start countdown OTP message
      _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
        counterOtp = otpCountDown(counterOtp);
        if(counterOtp.counter <= 0) {
          timer.cancel();
        }
        setState(() {});
      });
    }
  }
  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }
}