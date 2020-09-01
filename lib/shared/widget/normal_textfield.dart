import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:food_booking/shared/app_colors.dart';
import 'package:food_booking/shared/app_sizes.dart';

class NormalTextField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final TextEditingController controller;
  final bool obscureText;
  final String title;
  final TextInputType keyboardType;
  final String hintText;
  final errorText;
  final TextInputAction inputAction;
  final FocusNode focusNode;
  final Function onSubmited;
  final double labelTextSize;
  final double inputTextSize;
  final TextStyle inputTextStyle;
  final bool readOnly;
  final maxLines;
  final maxLength;

  NormalTextField({this.title,this.hintText,this.onChanged,this.controller,
    this.errorText,this.obscureText, this.keyboardType, this.inputAction, this.focusNode, this.onSubmited,
    this.labelTextSize, this.inputTextSize, this.readOnly, this.maxLines, this.maxLength, this.inputTextStyle});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        (title == null || title == '') ? Container() :
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.w400,decoration: TextDecoration.none, fontSize: (labelTextSize == null ? AppSizes.SIZE_LABEL_NORMAL: labelTextSize ) ?? AppSizes.SIZE_LABEL_INPUT, color: AppColors.colorTextFieldLabel),
        ),
        Container(height: 5,),
        TextField(
          keyboardType: keyboardType == null ? TextInputType.text : keyboardType,
          onChanged: onChanged,
          autocorrect: false,
          controller: controller,
          maxLength: maxLength == null ? null : maxLength,
          readOnly: readOnly == null ? false : readOnly,
          enabled: readOnly == null ? true : !readOnly,
          obscureText: obscureText == null ? false : obscureText,
          textInputAction: inputAction == null ? TextInputAction.done : inputAction,
          focusNode: focusNode != null ? focusNode : FocusNode(),
          style: inputTextStyle != null ? inputTextStyle : TextStyle(fontSize: inputTextSize ?? AppSizes.SIZE_LABEL_INPUT_HINT,color: AppColors.colorTextContent),
          maxLines: maxLines == null ? 1 : null,
          onSubmitted: onSubmited,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 12),
            fillColor: AppColors.colorTextFieldFillColor,
            filled: true,
            hintText: hintText,
            errorText: errorText == null ? null : errorText,
            errorStyle: TextStyle(fontSize: AppSizes.SIZE_LABEL_SMALL),
            hintStyle: TextStyle(fontSize: inputTextSize??AppSizes.SIZE_LABEL_INPUT_HINT, color: AppColors.colorTextHint),
            border: new OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                const Radius.circular(6.0),
              ),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.colorTextFieldBorderColor, width: 0.0),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                const Radius.circular(6.0),
              ),
              borderSide: const BorderSide(color: AppColors.colorTextFieldBorderColor, width: 0.0),
            ),
            disabledBorder: const OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.colorTextFieldBorderColor, width: 0.0),
            ),
          ),
        ),
      ],
    );
  }
}


class AppBarNormalTextField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final String hintText;
  final TextInputAction inputAction;
  final FocusNode focusNode;
  final Function onSubmited;
  final double labelTextSize;
  final double inputTextSize;
  final double height;
  final TextStyle inputTextStyle;
  final bool readOnly;
  final maxLines;
  final maxLength;

  AppBarNormalTextField({this.height = 30, this.hintText,this.onChanged,this.controller,
    this.obscureText, this.keyboardType, this.inputAction, this.focusNode, this.onSubmited,
    this.labelTextSize, this.inputTextSize, this.readOnly, this.maxLines, this.maxLength, this.inputTextStyle});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: this.height,
            child: TextField(
              keyboardType: keyboardType == null ? TextInputType.text : keyboardType,
              onChanged: onChanged,
              autocorrect: false,
              controller: controller,
              maxLength: maxLength == null ? null : maxLength,
              readOnly: readOnly == null ? false : readOnly,
              enabled: readOnly == null ? true : !readOnly,
              obscureText: obscureText == null ? false : obscureText,
              textInputAction: inputAction == null ? TextInputAction.done : inputAction,
              focusNode: focusNode != null ? focusNode : FocusNode(),
              style: inputTextStyle != null ? inputTextStyle : TextStyle(fontSize: inputTextSize ?? AppSizes.SIZE_LABEL_INPUT_HINT,color: AppColors.colorTextContent),
              maxLines: maxLines == null ? 1 : null,
              onSubmitted: onSubmited,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 12, top: 0, bottom: 0, right: 0),
                fillColor: AppColors.colorTextFieldFillColor,
                filled: true,
                hintText: hintText,
                errorStyle: TextStyle(fontSize: AppSizes.SIZE_LABEL_SMALL),
                hintStyle: TextStyle(fontSize: inputTextSize??AppSizes.SIZE_LABEL_INPUT_HINT, color: AppColors.colorTextHint),
                border: new OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(6.0),
                  ),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.colorTextFieldBorderColor, width: 0.0),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(6.0),
                  ),
                  borderSide: const BorderSide(color: AppColors.colorTextFieldBorderColor, width: 0.0),
                ),
                disabledBorder: const OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.colorTextFieldBorderColor, width: 0.0),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

