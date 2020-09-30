import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:food_booking/base/base_model.dart';
import 'package:food_booking/screens/common/success_page.dart';
import 'package:food_booking/screens/forgot/forgot_password.dart';
import 'package:food_booking/shared/widget/app_bar.dart';
import 'package:food_booking/shared/widget/loading.dart';
import 'package:food_booking/shared/widget/logo.dart';
import 'package:food_booking/shared/widget/normal_button.dart';
import 'package:food_booking/shared/widget/normal_textfield.dart';
import 'package:food_booking/utils/assets_link.dart';
import 'package:food_booking/utils/common.dart';
import 'package:food_booking/utils/validation.dart';
import 'package:provider/provider.dart';



class ForgotPassResetPage extends StatelessWidget
{
  final ForgotPassModel model;
  ForgotPassResetPage({this.model});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ForgotPassResetModel>(
      create: (context) => ForgotPassResetModel(),
      child: ForgotPassResetPageWidget(model: this.model,),
    );
  }
}


class ForgotPassResetPageWidget extends StatelessWidget {

  final ForgotPassModel model;
  ForgotPassResetPageWidget({this.model});

  final TextEditingController controllerPass = new TextEditingController();
  final TextEditingController controllerPassConfirm = new TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    ForgotPassResetModel pvdForgotPassReset = Provider.of<ForgotPassResetModel>(context);
    final FocusNode passFocus = FocusNode();
    final FocusNode passConfirmFocus = FocusNode();
    Widget _buildPassField() {
      return Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
        child: Stack(
          alignment: AlignmentDirectional.centerEnd,
          children: <Widget>[
            NormalTextField(
              controller: controllerPass,
              obscureText: !pvdForgotPassReset.isShowPass,
              title: 'Mật khẩu mới',
              hintText: 'Nhập mật khẩu mới',
              errorText: pvdForgotPassReset.errorValidPass,
              focusNode: passFocus,
              inputAction: TextInputAction.next,
              onSubmited: (term) {
                passFocus.unfocus();
                FocusScope.of(context).requestFocus(passConfirmFocus);
              },
            ),
            Container(
              margin: pvdForgotPassReset.errorValidPass == null ?  EdgeInsets.only(top: 20) : EdgeInsets.only(top: 0),
              height: 60,
              width: 50,
              child: IconButton(
                  icon: Image.asset( assetsLink + (pvdForgotPassReset.isShowPass ? 'icon_eye_close.png' : 'icon_eye.png'),height: 20,width: 20,),
                  onPressed: () => pvdForgotPassReset.showPass()
              ),
            )
          ],
        ),
      );
    }
    Widget _buildPassConfirmField() {
      return Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
        child: Stack(
          alignment: AlignmentDirectional.centerEnd,
          children: <Widget>[
            NormalTextField(
              controller: controllerPassConfirm,
              obscureText: !pvdForgotPassReset.isShowPassConfirm,
              title: 'Nhập lại mật khẩu mới',
              hintText: 'Nhập lại mật khẩu mới',
              errorText: pvdForgotPassReset.errorValidPassConfirm,
              focusNode: passConfirmFocus,
              inputAction: TextInputAction.done,
              onSubmited: (term) {
                Common.hideSoftKeyboard(context);
              },
            ),
            Container(
              margin: pvdForgotPassReset.errorValidPassConfirm == null ?  EdgeInsets.only(top: 20) : EdgeInsets.only(top: 0),
              height: 60,
              width: 50,
              child: IconButton(
                  icon: Image.asset( assetsLink + (pvdForgotPassReset.isShowPassConfirm ? 'icon_eye_close.png' : 'icon_eye.png'),height: 20,width: 20,),
                  onPressed: () => pvdForgotPassReset.showPassConfirm()
              ),
            )
          ],
        ),
      );
    }

    Widget _buildButtonContinue() {
      return Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 32),
        child: SizedBox(
            width: double.infinity,
            height: 56,
            child: NormalButton(
              title: 'Tiếp tục',
              onPress: () {
                if(pvdForgotPassReset.isValidInfo(
                    controllerPass.text.toString(),
                    controllerPassConfirm.text.toString()))
                {
                  resetPass(context, pvdForgotPassReset, controllerPass.text.toString(), controllerPassConfirm.text.toString(), this.model);
                }
              },
            )
        ),
      );
    }

    return Stack(
      children: <Widget>[
        Scaffold(
            backgroundColor: Colors.white,
            key: _scaffoldKey,
            appBar: BookingAppBar.getAppBar(
                title: "ĐỔI MẬT KHẨU",
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
                      padding: EdgeInsets.fromLTRB(30, 12, 30, 0),
                      constraints: BoxConstraints(minWidth: 100, maxWidth: 450),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              SharedLogo.logo(paddingTop: 0, paddingBottom: 32),
                              _buildPassField(),
                              _buildPassConfirmField(),
                              _buildButtonContinue(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
        ),
        LoadingView.widget(loading: pvdForgotPassReset.isShowLoading),
      ],
    );
  }

  void resetPass(BuildContext context, ForgotPassResetModel pvdForgotPassReset,
      String password, String confirmPassword,
      ForgotPassModel model){
    pvdForgotPassReset.showLoading(true);
    new Future.delayed(const Duration(seconds: 1), () async {
      pvdForgotPassReset.showLoading(false);
      Navigator.push(context, CupertinoPageRoute(builder: (BuildContext context) => SuccessPage(logo: "icon_success.png",
        content: "Cập nhật mật khẩu thành công, vui lòng đăng nhập lại để tiếp tục sử dụng.",
        title: "ĐỔI MẬT KHẨU",titleButton: "Đăng nhập",))
      );
    });
  }


}

class ForgotPassResetModel extends BaseModel{
  String errorValidPass;
  String errorValidPassConfirm;
  bool isShowPass = false;
  bool isShowPassConfirm = false;
  bool isValidPassConfirm = false;
  bool isValidPass = false;
  bool isValidInfo(String pass, String passConfirm) {

    if(Validation.isPassValid(pass.trim().toString())) {
      isValidPass = true;
      errorValidPass = null;
    }else {
      isValidPass = false;
      errorValidPass = "Mật khẩu không hợp lệ";
    }
    if(Validation.isPassValid(passConfirm.trim().toString())) {
      isValidPassConfirm = true;
      errorValidPassConfirm = null;
      if(pass.trim().toString() == passConfirm.trim().toString()) {
        isValidPassConfirm = true;
        errorValidPassConfirm = null;
      }else {
        isValidPassConfirm = false;
        errorValidPassConfirm = "Mật khẩu không đúng";
      }
    }else {
      isValidPassConfirm = false;
      errorValidPassConfirm = "Mật khẩu nhập lại không hợp lệ";
    }
    super.update();
    if(isValidPass && isValidPassConfirm) {
      return true;
    }else {
      return false;
    }
  }

  void showPass(){
    isShowPass = !isShowPass;
    super.update();
  }
  void showPassConfirm(){
    isShowPassConfirm = !isShowPassConfirm;
    super.update();
  }
}