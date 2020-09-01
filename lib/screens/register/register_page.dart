import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_booking/base/base_model.dart';
import 'package:food_booking/screens/register/register_otp.dart';
import 'package:food_booking/shared/app_sizes.dart';
import 'package:food_booking/shared/widget/app_bar.dart';
import 'package:food_booking/shared/widget/keyboard_layout.dart';
import 'package:food_booking/shared/widget/loading.dart';
import 'package:food_booking/shared/widget/normal_button.dart';
import 'package:food_booking/shared/widget/normal_textfield.dart';
import 'package:food_booking/utils/assets_link.dart';
import 'package:food_booking/utils/common.dart';
import '../../utils/validation.dart';

class RegisterInfoPage extends StatefulWidget {

  @override
  RegisterInfoState createState() => RegisterInfoState();
}

class RegisterInfoState extends State<RegisterInfoPage>
{
  RegisterInfoModel pvdRegisterInfo = new RegisterInfoModel();


  final TextEditingController controllerPhone = new TextEditingController(text: "0909090909");
  final TextEditingController controllerName = new TextEditingController(text: "Name");
  final TextEditingController controllerPass = new TextEditingController(text: "123456");
  final TextEditingController controllerPassConfirm = new TextEditingController(text: "123456");
  final FocusNode passFocus = FocusNode();
  final FocusNode phoneFocus = FocusNode();
  final FocusNode nameFocus = FocusNode();
  final FocusNode passConfirmFocus = FocusNode();
  final _scaffoldKey = GlobalKey<ScaffoldState>();


  int bottomSheetWidgetId = 0;


  @override
  Widget build(BuildContext context)
  {

    var bottomSheetMaxHeight = MediaQuery.of(context).size.height * 2/3;

    Widget _buildPhoneField() {
      return Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, AppSizes.FORM_EDIT_LINE_PADDING),
        child: NormalTextField(
          controller: controllerPhone,
          keyboardType: TextInputType.phone,
          title: 'Số điện thoại',
          hintText: 'Nhập số điện thoại',
          focusNode: phoneFocus,
          errorText: pvdRegisterInfo.errorValidPhone,
          inputAction: TextInputAction.next,
          onSubmited: (term) {
            phoneFocus.unfocus();
            nameFocus.requestFocus();
          },
        ),
      );
    }

    Widget _buildNameField() {
      return Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, AppSizes.FORM_EDIT_LINE_PADDING),
        child: NormalTextField(
          controller: controllerName,
          title: 'Họ và tên',
          hintText: 'Nhập họ và tên của bạn',
          focusNode: nameFocus,
          errorText: pvdRegisterInfo.errorValidName ,
          inputAction: TextInputAction.next,
          onSubmited: (term) {
            nameFocus.unfocus();
            passFocus.requestFocus();
          },
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
              errorText: pvdRegisterInfo.errorValidPass,
              obscureText: !pvdRegisterInfo.isShowPass,
              inputAction: TextInputAction.next,
              onSubmited: (term) {
                passFocus.unfocus();
                passConfirmFocus.requestFocus();
              },
            ),
            Container(
              margin: pvdRegisterInfo.errorValidPass == null ?  EdgeInsets.only(top: 20) : EdgeInsets.only(top: 0),
              height: 50,
              width: 50,
              child: IconButton(
                  icon: Image.asset( assetsLink + (pvdRegisterInfo.isShowPass ? 'icon_eye_close.png' : 'icon_eye.png'),height: 20,width: 20,),
                  onPressed: () => pvdRegisterInfo.showPass()
              ),
            )
          ],
        ),
      );
    }

    Widget _buildPassConfirmField() {
      return Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, AppSizes.FORM_EDIT_LINE_PADDING),
        child:  Stack(
          alignment: AlignmentDirectional.centerEnd,
          children: <Widget>[
            NormalTextField(
                controller: controllerPassConfirm,
                focusNode: passConfirmFocus,
                title: 'Nhập lại mật khẩu',
                hintText: 'Xác nhận lại mật khẩu',
                errorText: pvdRegisterInfo.errorValidPassConfirm,
                obscureText: !pvdRegisterInfo.isShowPassConfirm,
                inputAction: TextInputAction.done,
                onSubmited: (term) {
                  phoneFocus.unfocus();
                  passConfirmFocus.unfocus();
                }
            ),
            Container(
              margin: pvdRegisterInfo.errorValidPassConfirm == null ?  EdgeInsets.only(top: 20) : EdgeInsets.only(top: 0),
              height: 50,
              width: 50,
              child: IconButton(
                  icon: Image.asset( assetsLink + (pvdRegisterInfo.isShowPassConfirm ? 'icon_eye_close.png' : 'icon_eye.png'),height: 20,width: 20,),
                  onPressed: () => pvdRegisterInfo.showPassConfirm()
              ),
            )
          ],
        ),
      );
    }


    return GestureDetector(
      child: WillPopScope(
        child: Stack(
          children: <Widget>[
            Scaffold(
              backgroundColor: Colors.white,
              key: _scaffoldKey,
              appBar: BookingAppBar.getAppBar(
                  title: "ĐĂNG KÝ TÀI KHOẢN"
              ),
              body: GestureDetector(
                onTapUp: (detail) {
                  Common.hideSoftKeyboard(context);
                },
                child: Material(
                    color: Colors.white,
                    child: KeyboardLayoutBase(
                      nodes: [nameFocus, phoneFocus, passFocus, passConfirmFocus],
                      child: SingleChildScrollView(
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20, top: 12, right: 20, bottom: 12),
                            child: Column(
                              children: <Widget>[
                                _buildNameField(),
                                _buildPhoneField(),
                                _buildPassField(),
                                _buildPassConfirmField(),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: SizedBox(
                                    height: 56,
                                    width: double.infinity,
                                    child: NormalButton(
                                      autoWidth: true,
                                      title: 'Đăng ký',
                                      btnStyle: TextStyle(
                                          fontSize: AppSizes.SIZE_TEXT_BUTTON_SMALL,
                                          color: Colors.white),
                                      onPress: () {
                                        setState(() {
                                          if(pvdRegisterInfo.isValidInfo(
                                              name: controllerName.text.toString(),
                                              phoneEmail: controllerPhone.text.toLowerCase(),
                                              pass: controllerPass.text.toString(),
                                              passConfirm: controllerPassConfirm.text.toString())
                                          ) {
                                            register(context,pvdRegisterInfo);
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                Container(height: 24,)
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                ),
              ),
            ),
            LoadingView.widget(loading: pvdRegisterInfo.isShowLoading)
          ],
        ),
      ),
    );
  }


  void register(BuildContext context, RegisterInfoModel pvdRegisterInfo) async {
    pvdRegisterInfo.showLoading(true);
    Future.delayed(Duration(milliseconds: 500), () async {
      pvdRegisterInfo.showLoading(false);
      Navigator.push(context, CupertinoPageRoute(builder: (BuildContext context) => RegisterOTPPage(userRegister: UserRegister(phone: controllerPhone.text),)));
    });

  }
}

class UserRegister {
  String phone;
  String name;
  String pass;
  String passConfirm;
  String optToken;
  UserRegister({this.phone, this.name, this.pass, this.passConfirm, this.optToken});
}

class RegisterInfoModel extends BaseModel {


  String errorValidPhone ;
  String errorValidName ;
  String errorValidPass ;
  String errorValidPassConfirm ;
  bool isShowPass = false;
  bool isShowPassConfirm = false;
  bool isValidPass = false;
  bool isValidName = false;
  bool isValidPhoneEmail = false;
  bool isValidPassConfirm = false;
  bool isValidInfo({
    String phoneEmail, String name, String pass, String passConfirm, String city, String classData, String district,
    String school
  }) {
    bool validateResult = true;
    if(phoneEmail != null) {
      if(Validation.isPhoneValid(phoneEmail.trim().toString()) || !Validation.isEmailValid(phoneEmail.trim().toString())) {
        isValidPhoneEmail = true;
        errorValidPhone = null;
      }else {
        isValidPhoneEmail = false;
        errorValidPhone = "Số điện thoại/Email không hợp lệ";
        validateResult = false;
      }
    }
    if(pass != null) {
      if(Validation.isPassValid(pass.trim().toString())) {
        isValidPass = true;
        errorValidPass = null;
      }else {
        isValidPass = false;
        errorValidPass = "Mật khẩu không hợp lệ";
        validateResult = false;
      }
    }

    if(name != null) {
      if(name.trim().toString() != ''){
        isValidName = true;
        errorValidName = null;
      }else{
        isValidName = false;
        errorValidName = "Họ tên không hợp lệ";
        validateResult = false;
      }
    }

    if(passConfirm != null) {
      if(Validation.isPassValid(passConfirm.trim().toString())) {
        isValidPassConfirm = true;
        errorValidPassConfirm = null;
        if(pass.trim().toString() == passConfirm.trim().toString()) {
          isValidPassConfirm = true;
          errorValidPassConfirm = null;
        }else {
          isValidPassConfirm = false;
          errorValidPassConfirm = "Mật khẩu không đúng";
          validateResult = false;
        }
      }else {
        isValidPassConfirm = false;
        errorValidPassConfirm = "Mật khẩu nhập lại không hợp lệ";
        validateResult = false;
      }
    }

    super.update();
    return validateResult;
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
