import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:food_booking/shared/app_colors.dart';
import 'package:food_booking/shared/app_sizes.dart';

class SharedOtpInput {
  static Widget otpInput({
    @required TextEditingController controller,
    final Function(String) onTextChanged,
    final Function onDone
  })
  {
    return PinCodeTextField(
      autofocus: false,
      controller: controller,
      hideCharacter: false,
      highlight: true,
      highlightColor: AppColors.colorTitle,
      defaultBorderColor: AppColors.colorTextFieldBorderColor,
      hasTextBorderColor: AppColors.colorTextFieldBorderColor,
      pinBoxBorderWidth: 1,
      maxLength: AppSizes.OTP_CODE_LENGTH,
      onTextChanged: onTextChanged,
      wrapAlignment: WrapAlignment.center,
      pinBoxWidth: 56,
      pinBoxHeight: 56,
      pinBoxRadius: 5.0,
      pinBoxOuterPadding: EdgeInsets.all(12),
      pinBoxColor: AppColors.colorTextFieldFillColor,
      pinBoxDecoration: ProvidedPinBoxDecoration.defaultPinBoxDecoration,
      pinTextStyle: TextStyle(fontSize: 30.0,color: Colors.black),
      pinTextAnimatedSwitcherTransition: ProvidedPinBoxTextAnimation.scalingTransition,
      pinTextAnimatedSwitcherDuration: Duration(milliseconds: 300),
      onDone: (String result) {
        if(onDone != null) onDone(result);
      },
    );
  }
}