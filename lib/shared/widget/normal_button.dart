import 'package:flutter/material.dart';
import 'package:food_booking/shared/app_colors.dart';
import 'package:food_booking/shared/app_sizes.dart';
import 'package:food_booking/shared/style/btn_style.dart';

class NormalButton extends StatelessWidget {
  final VoidCallback onPress;
  final String title;
  final double minWidth;
  final TextStyle btnStyle;
  final Color bgColor;
  final double btnHeight;
  final bool autoWidth;
  NormalButton({@required this.onPress, this.title,
    this.minWidth, this.btnStyle, this.bgColor, this.btnHeight,
    this.autoWidth});

  @override
  Widget build(BuildContext context) {
    var _autoWidth = (autoWidth == null ? false : autoWidth);
    return ButtonTheme(
      minWidth: _autoWidth ? 0 : (minWidth ?? 200),
      height: btnHeight ?? 44,
      child: RaisedButton(
        onPressed: onPress,
//        splashColor: AppColors.colorButtonSelected,
        color: bgColor ?? AppColors.colorButtonBackground,
        disabledColor: bgColor ?? AppColors.colorButtonBackground,
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(6.0),
            side: BorderSide(color: Colors.transparent)
        ),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: bgColor ?? AppColors.colorButtonBackground,
                blurRadius: 12.0,
                spreadRadius: 4.0,
                offset: Offset(0.0, 0.0),
              ),
            ],
          ),
          child: Text(
            title,
            style: btnStyle ?? BtnStyle.normal(),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class BookingFlatButton extends StatelessWidget {
  final VoidCallback onPress;
  final String title;
  final double minWidth;
  final TextStyle btnStyle;
  final Color bgColor;
  final double btnHeight;
  final bool autoWidth;
  BookingFlatButton({@required this.onPress, this.title,
    this.minWidth, this.btnStyle, this.bgColor, this.btnHeight,
    this.autoWidth});

  @override
  Widget build(BuildContext context) {
    var _autoWidth = (autoWidth == null ? false : autoWidth);
    return ButtonTheme(
      minWidth: _autoWidth ? 0 : (minWidth ?? 200),
      height: btnHeight ?? 44,
      child: FlatButton(
        onPressed: onPress,
        splashColor: AppColors.colorButtonSelected,
        color: bgColor ?? AppColors.colorButtonBackground,
        disabledColor: bgColor ?? AppColors.colorButtonBackground,
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(6.0),
            side: BorderSide(color: Colors.transparent)
        ),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: bgColor ?? AppColors.colorButtonBackground,
                blurRadius: 12.0,
                spreadRadius: 4.0,
                offset: Offset(0.0, 0.0),
              ),
            ],
          ),
          child: Text(
            title,
            style: btnStyle ?? BtnStyle.normal(),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class NormalButtonNonBackGround extends StatelessWidget {
  final VoidCallback onPress;
  final String title;
  final double minWidth;
  final TextStyle btnStyle;
  final Color bgColor;
  final double btnHeight;
  final bool autoWidth;
  NormalButtonNonBackGround({@required this.onPress, this.title,
    this.minWidth, this.btnStyle, this.bgColor, this.btnHeight,
    this.autoWidth});

  @override
  Widget build(BuildContext context) {
    var _autoWidth = (autoWidth == null ? false : autoWidth);
    return ButtonTheme(
      minWidth: _autoWidth ? 0 : (minWidth ?? 200),
      height: btnHeight ?? 44,
      child: RaisedButton(
        onPressed: onPress,
        color: Colors.white,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.colorButtonBackground,
                blurRadius: 15.0,
                spreadRadius: 7.0,
                offset: Offset(0.0, 0.0),
              ),
            ],
          ),
          child: Text(
            title,
            style: btnStyle ?? TextStyle(
                fontSize: AppSizes.SIZE_TEXT_BUTTON_LARGE,
                color: AppColors.colorButtonBackground,
                fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),
    );
  }
}
