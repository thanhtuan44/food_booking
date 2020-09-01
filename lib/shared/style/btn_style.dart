import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_booking/shared/app_sizes.dart';

class BtnStyle {
  static TextStyle normal() {
    return TextStyle(
        fontSize: AppSizes.SIZE_TEXT_BUTTON_LARGE,
        color: Colors.white,
        fontWeight: FontWeight.w500
    );
  }

  static TextStyle small() {
    return TextStyle(
        fontSize: AppSizes.SIZE_TEXT_BUTTON_SMALL,
        color: Colors.white,
        fontWeight: FontWeight.w500
    );
  }

  static TextStyle smaller() {
    return TextStyle(
        fontSize: AppSizes.SIZE_TEXT_BUTTON_SMALLER,
        color: Colors.white,
        fontWeight: FontWeight.w500
    );
  }
}