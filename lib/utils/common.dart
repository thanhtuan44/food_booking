import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'dart:math';

import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_booking/shared/app_colors.dart';
import 'package:food_booking/shared/app_sizes.dart';



class Common {
  // iPhone 6S
  // |_ [portrait]
  //    |_ size: 375.0x667.0, pixelRatio: 2.0, pixels: 750.0x1334.0
  //       |_ diagonal: 765.1888655750291
  // |_ [horizontal]
  //    |_ size: 667.0x375.0, pixelRatio: 2.0, pixels: 1334.0x750.0
  //       |_ diagonal: 765.1888655750291

  // iPhone X
  // |_ [portrait]
  //    |_ size: 375.0x812.0, pixelRatio: 3.0, pixels: 1125.0x2436.0
  //       |_ diagonal: 894.4098613052072
  // |_ [horizontal]
  //    |_ size: 812.0x375.0, pixelRatio: 3.0, pixels: 2436.0x1125.0
  //       |_ diagonal: 894.4098613052072

  // iPhone XS Max
  // |_ [portrait]
  //    |_ size: 414.0x896.0, pixelRatio: 3.0, pixels: 1242.0x2688.0
  //       |_ diagonal: 987.0217829409845
  // |_ [horizontal]
  //    |_ size: 896.0x414.0, pixelRatio: 3.0, pixels: 2688.0x1242.0
  //       |_ diagonal: 987.0217829409845

  // iPad Pro (9.7-inch)
  // |_ [portrait]
  //    |_ size: 768.0x1024.0, pixelRatio: 2.0, pixels: 1536.0x2048.0
  //       |_ diagonal: 1280.0
  // |_ [horizontal]
  //    |_ size: 1024.0x768.0, pixelRatio: 2.0, pixels: 2048.0x1536.0
  //       |_ diagonal: 1280.0

  // iPad Pro (10.5-inch)
  // |_ [portrait]
  //    |_ size: 834.0x1112.0, pixelRatio: 2.0, pixels: 1668.0x2224.0
  //       |_ diagonal: 1390.0
  // |_ [horizontal]
  //    |_ size: 1112.0x834.0, pixelRatio: 2.0, pixels: 2224.0x1668.0
  //       |_ diagonal: 1390.0

  // iPad Pro (12.9-inch)
  // |_ [portrait]
  //    |_ size: 1024.0x1366.0, pixelRatio: 2.0, pixels: 2048.0x2732.0
  //       |_ diagonal: 1707.2000468603555
  // |_ [horizontal]
  //    |_ size: 1366.0x1024.0, pixelRatio: 2.0, pixels: 2732.0x2048.0
  //       |_ diagonal: 1707.2000468603555

  ///Hide soft keyboard
  static hideSoftKeyboard(BuildContext context)
  {
    if(context != null) {
      FocusScope.of(context).unfocus();
      FocusScope.of(context).requestFocus(new FocusNode());
    }
    try{
      SystemChannels.textInput.invokeMethod('TextInput.hide');
    } catch (ex) {
      return;
    }
  }
  static void showToast({@required String message, Color background}) {
    if(background == null) {
      background = AppColors.colorSnackBarSuccess;
    }
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: background,
        textColor: Colors.white,
        fontSize: AppSizes.SIZE_TEXT_LIST_CONTENT
    );
  }
  ///Show soft keyboard
  static showSoftKeyboard(BuildContext context, FocusNode node)
  {
    try{
      SystemChannels.textInput.invokeMethod('TextInput.show');
      if(context != null) {
        FocusScope.of(context).unfocus();
        FocusScope.of(context).requestFocus(node);
      }
    } catch (ex) {
      return;
    }
  }
  static bool isNullOrEmpty(String s) {
    return !(s != null && s != "");
  }
  static void showSnackBarWithKey({@required GlobalKey<ScaffoldState> scaffoldKey, @required String message, Color background}) {
    scaffoldKey.currentState.removeCurrentSnackBar();
    final snackBar = SnackBar(content: Text(message), backgroundColor: background,);
    scaffoldKey.currentState.showSnackBar(snackBar);
  }
  static fieldFocusChange(BuildContext context, FocusNode currentFocus,FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
  static String formatCurrency(double value)
  {
    return new FlutterMoneyFormatter(
        amount: value,
        settings: MoneyFormatterSettings(
            symbol: 'đ',
            thousandSeparator: '.',
            decimalSeparator: ',',
            symbolAndNumberSeparator: '',
            fractionDigits: 0,
            compactFormatType: CompactFormatType.short
        )
    ).output.symbolOnRight;
  }

  /// Replace string with specified string
  static String replacePartString(String input, String replaceWith)
  {
    String result = "";
    var startIndex = input.length / 2 - input.length / 4;
    if(startIndex < 1) startIndex = 1;
    for(var i = 0; i<input.length; i++) {
      if(i > startIndex && i < startIndex + input.length / 2) {
        result += replaceWith;
      } else {
        result += input[i];
      }
    }
    return result;
  }

  static Color getColorFromHex(String hexCode)
  {
    if(hexCode == null) return Colors.transparent;
    final buffer = StringBuffer();
    if (hexCode.length == 6 || hexCode.length == 7) buffer.write('ff');
    buffer.write(hexCode.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
