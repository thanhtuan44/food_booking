import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:food_booking/base/base_model.dart';
import 'package:food_booking/screens/common/success_page.dart';
import 'package:food_booking/screens/forgot/forgot_pass_otp.dart';
import 'package:food_booking/shared/widget/app_bar.dart';
import 'package:food_booking/shared/widget/logo.dart';
import 'package:food_booking/shared/widget/normal_button.dart';
import 'package:food_booking/shared/widget/normal_textfield.dart';
import 'package:food_booking/shared/widget/scale_animation.dart';
import 'package:food_booking/utils/common.dart';
import 'package:food_booking/utils/validation.dart';
import 'package:provider/provider.dart';


class ForgotPassPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ForgotPassModel>(
      create: (context) => ForgotPassModel(),
      child: ForgotPassPageWidget(),
    );
  }
}

class ForgotPassPageWidget extends StatelessWidget {
  final TextEditingController controllerPhoneEmail =
  new TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final String isType = "";

  @override
  Widget build(BuildContext context) {
    ForgotPassModel pvdForgotPass = Provider.of<ForgotPassModel>(context);
    final FocusNode phoneFocus = FocusNode();
    Widget _buildPhoneField() {
      return Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
        child: NormalTextField(
          controller: controllerPhoneEmail,
          keyboardType: TextInputType.emailAddress,
          title: 'Số điện thoại/Email',
          hintText: 'Nhập số điện thoại/Email',
          errorText: pvdForgotPass.warningPhonePass,
          focusNode: phoneFocus,
          inputAction: TextInputAction.done,
        ),
      );
    }

    return Stack(
      children: <Widget>[
        Scaffold(
            backgroundColor: Colors.white,
            key: _scaffoldKey,
            appBar: BookingAppBar.getAppBar(title: "LẤY LẠI MẬT KHẨU"),
            body: Center(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.fromLTRB(30, 24, 30, 24),
                  constraints: BoxConstraints(minWidth: 100, maxWidth: 450),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SharedLogo.logo(paddingTop: 0, paddingBottom: 48),
                      _buildPhoneField(),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                        child: SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: NormalButton(
                              title: 'Tiếp tục',
                              onPress: () {
                                pvdForgotPass.continueAction(context, _scaffoldKey,
                                    controllerPhoneEmail.text.toString());
                              },
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            )),
        pvdForgotPass.isShowLoading
            ? Container(
          color: Colors.black12,
          child: Center(
              child: ScaleAnimation(
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: new BoxDecoration(
                    color: Colors.black45,
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  child: SpinKitCircle(
                    color: Colors.white,
                  ),
                ),
              )),
        )
            : Container(
          width: 0,
          height: 0,
        ),
      ],
    );
  }
}

class ForgotPassModel extends BaseModel {
  String warningPhonePass;
  String phoneEmail;
  String otpToken;
  String otpCode;

  void continueAction(BuildContext context, GlobalKey<ScaffoldState> _scaffoldKey, String phoneEmail) async
  {
    warningPhonePass = null;
    if(phoneEmail.trim() == "") {
      warningPhonePass = "Số điện thoại/Email không hợp lệ.";
    } else {
      this.showLoading(true);
      Future.delayed(Duration(milliseconds: 500), () async {
        this.showLoading(false);
        warningPhonePass = null;
        this.phoneEmail = phoneEmail;
        if (Validation.checkTypePhoneEmailValid(phoneEmail.trim().toString()) == "email") {
          Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (BuildContext context) => SuccessPage(
                    content:
                    "Link reset mật khẩu đã được gửi đến email của bạn. Vui lòng kiểm tra email và làm theo hướng dẫn.",
                    logo: "icon_mail.png",
                    title: "MẬT KHẨU MỚI",
                  )));

        } else if (Validation.checkTypePhoneEmailValid(phoneEmail.trim().toString()) == "phone") {
          Navigator.push(context, CupertinoPageRoute(builder: (BuildContext context) => ForgotPassOTPPage(model: this)));
        }

        super.update();
      });
    }
    super.update();
  }
}
