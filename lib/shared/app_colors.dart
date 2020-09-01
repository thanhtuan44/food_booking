import 'package:flutter/material.dart';

class AppColors {
  // ignore: non_constant_identifier_names
  static final MaterialColor PRIMARY_COLOR = _factoryColor(0xff2B3340);

  // ignore: non_constant_identifier_names
  static final MaterialColor LIGHT = _factoryColor(0xfff4f4f8);

  // ignore: non_constant_identifier_names
  static final MaterialColor LIGHT_GREY = _factoryColor(0xffd8d8d8);

  // ignore: non_constant_identifier_names
  static final MaterialColor DARK = _factoryColor(0xff3a3a3a);

  // ignore: non_constant_identifier_names
  static final MaterialColor WHITE = _factoryColor(0xffffffff);

  // ignore: non_constant_identifier_names
  static final MaterialColor GREEN = _factoryColor(0xff349e40);

  // ignore: non_constant_identifier_names
  static final MaterialColor LIGHT_GREEN = _factoryColor(0xff3AB54A);

  // ignore: non_constant_identifier_names
  static final MaterialColor SHADOW = _factoryColor(0xffE7EAF0);

  static MaterialColor hex(String hex) => AppColors._factoryColor(AppColors._getColorHexFromStr(hex));

  static MaterialColor _factoryColor(int color) {
    return MaterialColor(color, <int, Color>{
      50: Color(color),
      100: Color(color),
      200: Color(color),
      300: Color(color),
      400: Color(color),
      500: Color(color),
      600: Color(color),
      700: Color(color),
      800: Color(color),
      900: Color(color),
    });
  }

  static int _getColorHexFromStr(String colorStr) {
    colorStr = "FF" + colorStr;
    colorStr = colorStr.replaceAll("#", "");
    int val = 0;
    int len = colorStr.length;
    for (int i = 0; i < len; i++) {
      int hexDigit = colorStr.codeUnitAt(i);
      if (hexDigit >= 48 && hexDigit <= 57) {
        val += (hexDigit - 48) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 65 && hexDigit <= 70) {
        // A..F
        val += (hexDigit - 55) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 97 && hexDigit <= 102) {
        // a..f
        val += (hexDigit - 87) * (1 << (4 * (len - 1 - i)));
      } else {
        val = 0xFFFFFFFF;
      }
    }
    return val;
  }
  static const orange = Color.fromRGBO(213, 75, 18, 1);
  static const buttonColor = Color.fromRGBO(216, 7, 7, 1);
  static const colorBackground = Color.fromRGBO(178,223,238,1);
  static const colorTextHint = Color.fromRGBO(203, 207, 218, 1);
  static const colorTextHintWhite = Colors.white30;
  static const colorTextFieldLabel =  Color.fromRGBO(100, 109, 132, 1);
  static const colorTextFieldLabelDark = Color.fromRGBO(5,30,48, 1);
  static const colorLabel =  Color.fromRGBO(239, 74, 93, 1);
  static const colorButtonBackground = Color.fromRGBO(239, 74, 93, 1);
  static const colorButtonSelected= Color.fromRGBO(247, 232, 211, 1);
  static const colorButtonDetailBackground = Color.fromRGBO(252,239,239, 1);
  static const colorButtonBackgroundDisabled = Color.fromRGBO(100, 109, 132, 1);
  static const colorTextFieldBottomBorder = Color.fromRGBO(241, 179, 87, 1);
  static const colorButtonWarning = Color.fromRGBO(179, 135, 43, 1);
  static const colorButtonError = Color.fromRGBO(216, 6, 6, 1);
  static const colorButtonBlack = Color.fromRGBO(80, 80, 80, 1);
  static const colorButtonSuccess = Color.fromRGBO(48, 166, 74, 1);
  static const colorLogoBookingDark = Color.fromRGBO(139,94,60, 1);
  static const colorLogoBookingAccent = Color.fromRGBO(252,176,65, 1);
  static const colorKeyboardBackground = Color.fromRGBO(209, 212, 219, 1);

  static const colorBackgroundErrorMessage = Color.fromRGBO(252,239,239, 1);
  static const colorSnackBarSuccess = Color.fromRGBO(67, 160, 71, 1);
  static const colorSnackBarWarning = Color.fromRGBO(175, 132, 28, 1);
  static const colorSnackBarError = Color.fromRGBO(212, 51, 52, 1);

  static const colorNavigationTextNormal = Color.fromRGBO(37, 37, 37, 0.5);
  static const colorNavigationTextSelected = Color.fromRGBO(37, 37, 37, 1);
  static const colorBackgroundAppBar = Color.fromRGBO(255, 255, 255, 1);
  static const colorBackgroundAppBarSeller = Color.fromRGBO(95, 131, 167, 1);
  static const colorBackgroundWhite20 = Color.fromRGBO(255, 255, 255, 0.2);
  static const colorBackgroundGrid = Color.fromRGBO(246, 246, 246, 1);
  static const colorBackgroundTextField = Color.fromRGBO(255, 255, 255, 0.5);
  static const colorGridShadowBorder = Color.fromRGBO(230, 230, 230, 1);

  static const colorTextTitle = Color.fromRGBO(37, 37, 37, 1);
  static const colorDetailTextTitle = Color.fromRGBO(96, 96, 96, 1);
  static const colorTextAppBar = Colors.white;
  static const colorTextContent = Color.fromRGBO(132, 96, 66, 1);
  static const colorTextLink = Color.fromRGBO(114, 169, 214, 1);
  static const colorTextLinkBlur = Color.fromRGBO(114, 169, 214, 0.8);

  static const Color colorBoxShadow = Color.fromRGBO(235, 235, 235, 1);
  static const Color colorListSeparate = Color.fromRGBO(37, 37, 37, 0.5);

  static const colorTextFieldFillColor = Color.fromRGBO(248,249,255, 1);
  static const colorTextFieldBorderColor = Color.fromRGBO(217,220,239, 1);
  static const colorTitle = Color.fromRGBO(132, 96, 66, 1);

  static const colorHeaderBooking = Color.fromRGBO(247, 236, 220, 1);
  static const colorHeaderProfile = Color.fromRGBO(248, 249, 255, 1);
  static const colorBorderItem= Color.fromRGBO(217, 220, 239, 1);
  static const backgroundDashboardTopup = Color.fromRGBO(255,209,143, 0.3);
  static const backgroundBoxColor = Color.fromRGBO(248,249,255, 1);
}