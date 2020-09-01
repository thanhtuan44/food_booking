import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_booking/base/base_model.dart';
import 'package:food_booking/data/spref.dart';
import 'package:food_booking/models/user_model.dart';
import 'package:food_booking/screens/forgot/forgot_password.dart';
import 'package:food_booking/screens/home_page.dart';
import 'package:food_booking/screens/register/register_page.dart';
import 'package:food_booking/shared/app_colors.dart';
import 'package:food_booking/shared/app_consts.dart';
import 'package:food_booking/shared/app_session.dart';
import 'package:food_booking/shared/app_sizes.dart';
import 'package:food_booking/shared/widget/keyboard_layout.dart';
import 'package:food_booking/shared/widget/loading.dart';
import 'package:food_booking/shared/widget/logo.dart';
import 'package:food_booking/shared/widget/normal_button.dart';
import 'package:food_booking/shared/widget/normal_textfield.dart';
import 'package:food_booking/utils/assets_link.dart';
import 'package:food_booking/utils/validation.dart';
import 'package:provider/provider.dart';

import '../../utils/common.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginModel>(
      create: (context) => LoginModel(),
      child: LoginPageWidget(),
    );
  }
}

class LoginPageWidget extends StatelessWidget
{

  final FocusNode passFocus = FocusNode();
  final FocusNode phoneFocus = FocusNode();
  final TextEditingController controllerPhone = new TextEditingController(text: "0907152251");
  final TextEditingController controllerPass = new TextEditingController(text:"123456");
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context)
  {
    LoginModel pvdLogin = Provider.of<LoginModel>(context);
    Widget _buildPhoneField() {
      return  Padding(
        padding: EdgeInsets.only(bottom: 16),
        child:
        NormalTextField(
            controller: controllerPhone,
            keyboardType: TextInputType.phone,
            title: 'Số điện thoại/Email',
            hintText: 'Nhập số điện thoại/Email',
            errorText: pvdLogin.warningPhone,
            inputAction: TextInputAction.next,
            focusNode: phoneFocus,
            onSubmited: (term) {
              Common.fieldFocusChange(context, phoneFocus, passFocus);
            }
        ),
      );
    }
    Widget _buildPassField() {
      return Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, AppSizes.FORM_EDIT_LINE_PADDING),
        child:  Stack(
          alignment: AlignmentDirectional.centerEnd,
          children: <Widget>[
            NormalTextField(
                controller: controllerPass,
                focusNode: passFocus,
                title: 'Mật khẩu',
                hintText: 'Nhập mật khẩu',
                errorText: pvdLogin.warningPass,
                obscureText: !pvdLogin.isShowPass,
                inputAction: TextInputAction.done,
                onSubmited: (term) {
                  Common.hideSoftKeyboard(context);
                }
            ),
            Container(
              margin: pvdLogin.warningPass == null ?  EdgeInsets.only(top: 20) : EdgeInsets.only(top: 0) ,
              height: 50,
              width: 50,
              child: Semantics(
                child: InkWell(
                  child: IconButton(
                      icon: Image.asset( assetsLink + (pvdLogin.isShowPass ? 'icon_eye_close.png' : 'icon_eye.png'),height: 20,width: 20,),
                      onPressed: () => pvdLogin.showPass()
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }
    Widget _registerForgot(BuildContext context) {
      return Padding(
        padding: EdgeInsets.only(top: 40, left: 4, right: 4),
        child: Container(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GestureDetector(
                  onTap: () {
                    pvdLogin.showLoading(true);
                    Future.delayed(Duration(milliseconds: 500), () async {
                      Navigator.push(context, CupertinoPageRoute(builder: (BuildContext context) => ForgotPassPage()));
                      pvdLogin.showLoading(false);
                    });
                  },
                  child: Text('Quên mật khẩu',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: AppSizes.SIZE_LABEL_NORMAL, color: AppColors.colorLabel,decoration: TextDecoration.none,)
                    ,)
              ),
              GestureDetector(
                  onTap: () {
                    pvdLogin.showLoading(true);
                    Future.delayed(Duration(milliseconds: 500), () async {
                      Navigator.push(context, CupertinoPageRoute(builder: (BuildContext context) => RegisterInfoPage()));
                      pvdLogin.showLoading(false);
                    });
                  },
                  child: Text('Đăng ký tài khoản',
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: AppSizes.SIZE_LABEL_NORMAL, color: AppColors.colorLabel,decoration: TextDecoration.none,)
                  )
              ),
            ],
          ),
        ),
      );
    }

    return Stack(
      children: <Widget>[
        Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.white,
          body: KeyboardLayoutBase(
            nodes: [phoneFocus, passFocus],
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.fromLTRB(32, 0, 32, 24),
                constraints: BoxConstraints(minWidth: 100, maxWidth: 450),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(child: SharedLogo.logo(paddingTop: 100, paddingBottom: 60),),
                    _buildPhoneField(),
                    _buildPassField(),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: NormalButton(
                            title: 'Đăng nhập',
                            onPress: () {
                              if(pvdLogin.isValidInfo(controllerPhone.text.trim(), controllerPass.text.trim())){
                                login(context, pvdLogin);
                              }
                            },
                          )
                      ),
                    ),
                    _registerForgot(context),
                  ],
                ),
              ),
            ),
          ),
        ),
        LoadingView.widget(loading: pvdLogin.isShowLoading)
      ],
    );
  }
  void login(BuildContext context, LoginModel pvdLogin) async{
    pvdLogin.showLoading(true);
    Future.delayed(Duration(milliseconds: 500), () async {
      UserProfile.setUser(controllerPhone.text);
      AppSession.instance.setSession(userName: controllerPhone.text);
      Navigator.pushReplacement(context, CupertinoPageRoute(builder: (BuildContext context) => HomePage()));
      pvdLogin.showLoading(false);
    });
  }
}

class LoginModel extends BaseModel {
  String warningPhone;
  String warningPass;
  bool isShowPass = false;


  bool isValidInfo(String phone, String pass) {
    bool isPassValid = false;
    bool isPhoneValid = false;
    if (Validation.isPassValid(pass)) {
      warningPass = null;
      isPassValid = true;
    } else {
      warningPass = "Mật khẩu không hợp lệ";
      isPassValid = false;
    }
    if (Validation.isPhoneValid(phone) || !Validation.isEmailValid(phone)) {
      warningPhone = null;
      isPhoneValid = true;
    } else {
      warningPhone = "Số điện thoại/Email không hợp lệ";
      isPhoneValid = false;
    }
    super.update();
    if (isPassValid && isPhoneValid) {
      return true;
    } else {
      return false;
    }
  }
  void showPass(){
    isShowPass = !isShowPass;
    super.update();
  }
}

