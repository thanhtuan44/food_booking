import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_booking/shared/app_colors.dart';
import 'package:food_booking/shared/app_sizes.dart';


class BookingAppBar
{
  static AppBar getAppBar({
    String title = '',
    bool showBackButton = true,
    List<Widget> actionButtons,
    Color appBarColor = AppColors.colorTitle,
    Color backgroundColor = Colors.white,
    double elevation = 0,
    bool centerTitle = true,
    Widget bottom,
  }) {
    return AppBar (
      elevation: elevation,
      backgroundColor: backgroundColor,
      brightness: Brightness.light, // status bar brightness
      centerTitle: centerTitle,
      iconTheme: IconThemeData(color: appBarColor),
      title: (title != null && title != '') ? Text(
          title, style: TextStyle(fontSize: AppSizes.SIZE_APPBAR_TITLE, color: appBarColor, letterSpacing: 1.53)) : null,
      leading: showBackButton ? BackButton() : Container(),
      actions: actionButtons,
      bottom: bottom,
    );
  }

}


